use std::collections::HashMap;

impl Solution {
    pub fn number_of_pairs(nums: Vec<i32>) -> Vec<i32> {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }
        let pairs = freq.values().map(|&v| v / 2).sum();
        let leftovers = freq.values().map(|&v| v % 2).sum();
        vec![pairs, leftovers]
    }
}