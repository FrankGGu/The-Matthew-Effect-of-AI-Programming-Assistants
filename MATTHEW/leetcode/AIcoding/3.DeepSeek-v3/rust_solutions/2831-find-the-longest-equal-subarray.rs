use std::collections::HashMap;

impl Solution {
    pub fn longest_equal_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = HashMap::new();
        let mut left = 0;
        let mut max_freq = 0;

        for right in 0..nums.len() {
            *freq.entry(nums[right]).or_insert(0) += 1;
            max_freq = max_freq.max(*freq.get(&nums[right]).unwrap());

            while (right - left + 1 - max_freq) > k as usize {
                *freq.get_mut(&nums[left]).unwrap() -= 1;
                left += 1;
            }
        }

        max_freq as i32
    }
}