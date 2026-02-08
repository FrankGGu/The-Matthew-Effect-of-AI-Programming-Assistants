use std::collections::HashMap;

impl Solution {
    pub fn min_length_after_removals(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }
        let max_freq = freq.values().max().unwrap_or(&0);
        if *max_freq * 2 > nums.len() as i32 {
            (2 * *max_freq - nums.len() as i32) as i32
        } else {
            (nums.len() as i32 % 2) as i32
        }
    }
}