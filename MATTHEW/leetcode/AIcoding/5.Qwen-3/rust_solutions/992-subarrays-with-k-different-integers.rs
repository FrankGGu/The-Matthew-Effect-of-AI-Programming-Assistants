impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn subarrays_with_k_diff_ints(nums: Vec<i32>, k: i32) -> i32 {
        fn at_most_k_distinct(nums: &[i32], k: i32) -> i32 {
            let mut count = HashMap::new();
            let mut left = 0;
            let mut res = 0;
            for right in 0..nums.len() {
                *count.entry(nums[right]).or_insert(0) += 1;
                while count.len() > k as usize {
                    *count.get_mut(&nums[left]).unwrap() -= 1;
                    if *count.get_mut(&nums[left]).unwrap() == 0 {
                        count.remove(&nums[left]);
                    }
                    left += 1;
                }
                res += right - left + 1;
            }
            res
        }
        at_most_k_distinct(&nums, k) - at_most_k_distinct(&nums, k - 1)
    }
}
}