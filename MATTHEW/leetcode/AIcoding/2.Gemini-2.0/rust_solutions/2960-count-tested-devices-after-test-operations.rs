impl Solution {
    pub fn count_tested_devices(battery_percentages: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut decrease = 0;
        for &battery in &battery_percentages {
            if battery - decrease > 0 {
                count += 1;
                decrease += 1;
            }
        }
        count
    }
}