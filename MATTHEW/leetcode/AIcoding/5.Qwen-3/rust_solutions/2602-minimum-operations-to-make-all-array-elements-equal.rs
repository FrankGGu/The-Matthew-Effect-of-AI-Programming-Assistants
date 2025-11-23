impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut max_freq = 0;
        for &count in freq.values() {
            if count > max_freq {
                max_freq = count;
            }
        }

        nums.len() as i32 - max_freq
    }
}
}