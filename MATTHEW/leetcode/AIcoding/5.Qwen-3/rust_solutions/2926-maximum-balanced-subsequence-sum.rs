impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_balanced_subsequence_sum(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut pairs = Vec::with_capacity(n);
        for i in 0..n {
            pairs.push((nums[i], i as i32));
        }

        pairs.sort_by(|a, b| {
            if a.0 != b.0 {
                a.0.cmp(&b.0)
            } else {
                a.1.cmp(&b.1)
            }
        });

        let mut dp = vec![0; n];
        let mut max_dp = 0;

        for i in 0..n {
            let (val, idx) = pairs[i];
            dp[i] = val;
            for j in 0..i {
                let (prev_val, prev_idx) = pairs[j];
                if prev_idx < idx && (idx - prev_idx) <= k {
                    dp[i] = std::cmp::max(dp[i], prev_val + val);
                }
            }
            max_dp = std::cmp::max(max_dp, dp[i]);
        }

        max_dp
    }
}
}