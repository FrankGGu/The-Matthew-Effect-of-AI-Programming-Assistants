use std::collections::HashMap;

impl Solution {
    pub fn maximum_length(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut dp = vec![vec![1; k + 1]; n];
        let mut max_len = 1;

        for i in 1..n {
            for prev_k in 0..=k {
                let mut current_max = 1;
                for j in 0..i {
                    let diff = if nums[j] == nums[i] { 0 } else { 1 };
                    if prev_k >= diff {
                        let new_len = dp[j][prev_k - diff] + 1;
                        if new_len > current_max {
                            current_max = new_len;
                        }
                    }
                }
                dp[i][prev_k] = current_max;
                if current_max > max_len {
                    max_len = current_max;
                }
            }
        }

        max_len
    }
}