impl Solution {
    pub fn find_radius(mut houses: Vec<i32>, mut heaters: Vec<i32>) -> i32 {
        houses.sort();
        heaters.sort();

        let mut max_min_radius_for_all_houses = 0;
        let mut heater_idx = 0;

        for &house in houses.iter() {
            while heater_idx + 1 < heaters.len() && heaters[heater_idx + 1] <= house {
                heater_idx += 1;
            }

            let dist_to_left_or_at_heater = (house - heaters[heater_idx]).abs();
            let mut min_dist_for_current_house = dist_to_left_or_at_heater;

            if heater_idx + 1 < heaters.len() {
                let dist_to_right_heater = (house - heaters[heater_idx + 1]).abs();
                min_dist_for_current_house = min_dist_for_current_house.min(dist_to_right_heater);
            }

            max_min_radius_for_all_houses = max_min_radius_for_all_houses.max(min_dist_for_current_house);
        }

        max_min_radius_for_all_houses
    }
}