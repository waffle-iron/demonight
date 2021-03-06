require "rails_helper"

describe "when an admin creates a demo night", js: true do

  before do
    @demo_night = create(:demo_night)
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end

  it "they are redirected to an index page if another demo night is active" do
    visit new_admin_demo_night_path

    fill_in "Name", with: "Demo Night - 1602"
    click_button "Create Demo Night!"

    expect(current_path).to eq(admin_demo_nights_path)
    expect(page).to have_content("There can only be 1 active demo night at a time.")
    within('.active-demo-night') do
      expect(page).to have_content(@demo_night.name)
    end

  end
end
