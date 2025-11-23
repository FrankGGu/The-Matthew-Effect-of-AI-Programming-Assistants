use std::collections::HashMap;

impl Solution {
    pub fn number_of_beautiful_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut result = 0;
        let mut current_odd_count = 0;
        let mut freq_map = vec![0; nums.len() + 1]; 

        freq_map[0] = 1;

        for num in nums {
            if num % 2 != 0 {
                current_odd_count += 1;
            }

            let target_prefix_odd_count = current_odd_count - k;

            if target_prefix_odd_count >= 0 {
                result += freq_map[target_prefix_odd_count as usize];
            }

            freq_map[current_odd_count as usize] += 1;
        }

        result
    }
}