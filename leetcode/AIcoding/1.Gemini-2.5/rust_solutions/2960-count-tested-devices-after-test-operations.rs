impl Solution {
    pub fn count_tested_devices(mut battery_levels: Vec<i32>) -> i32 {
        let n = battery_levels.len();
        let mut tested_count = 0;

        for i in 0..n {
            if battery_levels[i] > 0 {
                tested_count += 1;
                // Decrement battery levels of all subsequent devices
                // that still have a positive charge.
                for j in (i + 1)..n {
                    if battery_levels[j] > 0 {
                        battery_levels[j] -= 1;
                    }
                }
            }
        }
        tested_count
    }
}