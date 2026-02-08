impl Solution {
    pub fn count_tested_devices(battery_percentages: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut battery_percentages = battery_percentages;
        for i in 0..battery_percentages.len() {
            if battery_percentages[i] > count {
                count += 1;
            }
        }
        count
    }
}