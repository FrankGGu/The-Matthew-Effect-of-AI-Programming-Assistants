impl Solution {
    pub fn find_radius(houses: Vec<i32>, heaters: Vec<i32>) -> i32 {
        let mut heaters = heaters;
        heaters.sort();
        let mut radius = 0;

        for house in houses {
            let pos = heaters.binary_search(&house).unwrap_or_else(|x| x);
            let left_heater = if pos > 0 { heaters[pos - 1] } else { i32::MIN };
            let right_heater = if pos < heaters.len() { heaters[pos] } else { i32::MAX };

            radius = radius.max((house - left_heater).abs().min((house - right_heater).abs()));
        }

        radius
    }
}