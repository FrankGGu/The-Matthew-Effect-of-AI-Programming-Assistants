use std::collections::HashMap;

impl Solution {
    pub fn max_frequency_elements(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }
        let max_freq = freq.values().max().unwrap_or(&0);
        freq.values().filter(|&&v| v == *max_freq).sum()
    }
}