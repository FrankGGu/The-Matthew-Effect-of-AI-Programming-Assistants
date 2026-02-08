use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn maximize_the_top(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        if k == 0 {
            return if n > 0 { nums[0] } else { -1 };
        }
        if k as usize > n {
            return *nums.iter().max().unwrap();
        }
        let mut max_num = *nums.iter().take(k as usize).max().unwrap();
        if k as usize < n {
            max_num = max_num.max(nums[k as usize]);
        }
        max_num
    }
}