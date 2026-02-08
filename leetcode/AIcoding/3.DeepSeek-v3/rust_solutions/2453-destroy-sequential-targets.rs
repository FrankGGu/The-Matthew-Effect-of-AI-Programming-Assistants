use std::collections::HashMap;

impl Solution {
    pub fn destroy_targets(nums: Vec<i32>, space: i32) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            let key = num % space;
            *freq.entry(key).or_insert(0) += 1;
        }

        let max_freq = *freq.values().max().unwrap_or(&0);
        let mut candidates = Vec::new();

        for &num in &nums {
            let key = num % space;
            if freq.get(&key).unwrap_or(&0) == &max_freq {
                candidates.push(num);
            }
        }

        *candidates.iter().min().unwrap_or(&0)
    }
}