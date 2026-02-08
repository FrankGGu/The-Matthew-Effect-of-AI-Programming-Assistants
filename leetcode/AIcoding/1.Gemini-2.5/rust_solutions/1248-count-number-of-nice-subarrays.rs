use std::collections::HashMap;

impl Solution {
    pub fn number_of_nice_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut prefix_odd_counts = HashMap::new();
        prefix_odd_counts.insert(0, 1);

        let mut current_odd_count = 0;
        let mut nice_subarrays_count = 0;

        for num in nums {
            if num % 2 != 0 {
                current_odd_count += 1;
            }

            if let Some(&count) = prefix_odd_counts.get(&(current_odd_count - k)) {
                nice_subarrays_count += count;
            }

            *prefix_odd_counts.entry(current_odd_count).or_insert(0) += 1;
        }

        nice_subarrays_count
    }
}