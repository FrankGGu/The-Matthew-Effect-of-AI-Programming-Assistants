use std::collections::HashMap;

impl Solution {
    pub fn number_of_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut prefix_counts = HashMap::new();
        prefix_counts.insert(0, 1);
        let mut result = 0;
        let mut current_odd_count = 0;

        for num in nums {
            current_odd_count += num % 2;
            if let Some(&count) = prefix_counts.get(&(current_odd_count - k)) {
                result += count;
            }
            *prefix_counts.entry(current_odd_count).or_insert(0) += 1;
        }

        result
    }
}