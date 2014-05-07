# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class DetailedPageTest < ActionController::IntegrationTest
  fixtures :projects, :trackers, :issue_statuses, :issues,
           :enumerations, :users, :issue_categories, :queries,
           :projects_trackers,
           :roles,
           :member_roles,
           :members,
           :enabled_modules,
           :workflows,
           :custom_values

  ActiveRecord::Fixtures.create_fixtures(File.dirname(__FILE__) + '/../fixtures/',
                                         [:custom_fields, :custom_fields_projects, :custom_fields_trackers])

  def login_with_user
    visit '/'
    click_link 'Sign in'
    assert page.has_link?("Lost password")

    fill_in 'username', with: 'jsmith'
    fill_in 'password', with: 'jsmith'
    click_button 'Login'
    assert page.has_link?("Sign out")
  end

  def logout
    visit '/'
    click_link 'Sign out'
    assert page.has_link?("Sign in")
  end


  def setup
    login_with_user
    visit 'projects/ecookbook/issues_xls_export'
    assert_not_nil page
  end

  def test_to_show_issue_export_offset_setting
    assert page.has_selector?('input#issues_export_offset')
  end

  def teardown
    logout
  end
end