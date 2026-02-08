use std::collections::HashMap;

impl Solution {
    pub fn subarrays_with_k_distinct(nums: Vec<i32>, k: i32) -> i32 {
        fn at_most_k(nums: &[i32], k: i32) -> i32 {
            let mut count = 0;
            let mut left = 0;
            let mut freq = HashMap::new();
            for right in 0..nums.len() {
                *freq.entry(nums[right]).or_insert(0) += 1;
                while freq.len() > k as usize {
                    *freq.get_mut(&nums[left]).unwrap() -= 1;
                    if freq[&nums[left]] == 0 {
                        freq.remove(&nums[left]);
                    }
                    left += 1;
                }
                count += right - left + 1;
            }
            count as i32
        }
        at_most_k(&nums, k) - at_most_k(&nums, k - 1)
    }
}