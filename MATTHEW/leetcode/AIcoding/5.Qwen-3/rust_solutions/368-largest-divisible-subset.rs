impl Solution {

use std::cmp::Reverse;
use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn largest_divisible_subset(nums: Vec<i32>) -> Vec<i32> {
        if nums.is_empty() {
            return vec![];
        }

        let mut nums = nums;
        nums.sort();

        let mut dp = vec![1; nums.len()];
        let mut prev = vec![-1; nums.len()];
        let mut max_len = 1;
        let mut max_idx = 0;

        for i in 1..nums.len() {
            for j in 0..i {
                if nums[i] % nums[j] == 0 {
                    if dp[j] + 1 > dp[i] {
                        dp[i] = dp[j] + 1;
                        prev[i] = j as i32;
                    }
                }
            }
            if dp[i] > max_len {
                max_len = dp[i];
                max_idx = i;
            }
        }

        let mut result = Vec::new();
        let mut idx = max_idx;
        while idx != -1 {
            result.push(nums[idx]);
            idx = prev[idx];
        }

        result.reverse();
        result
    }
}
}