impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn constrained_subsequence_sum(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut dq = VecDeque::new();
        let mut dp = vec![0; n];

        for i in 0..n {
            while !dq.is_empty() && dq.front().unwrap() < &i - k {
                dq.pop_front();
            }

            let prev = if dq.is_empty() { 0 } else { dp[dq.front().unwrap()] };
            dp[i] = prev + nums[i];

            while !dq.is_empty() && dp[i] >= dp[dq.back().unwrap()] {
                dq.pop_back();
            }

            dq.push_back(i);
        }

        *dp.iter().max().unwrap()
    }
}
}