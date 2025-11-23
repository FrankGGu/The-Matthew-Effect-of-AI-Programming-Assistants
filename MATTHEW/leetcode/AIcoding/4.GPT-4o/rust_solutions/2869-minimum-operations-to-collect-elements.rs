impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut counts = std::collections::HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let max_count = counts.values().cloned().max().unwrap_or(0);
        nums.len() as i32 - max_count
    }
}