use std::collections::HashMap;

impl Solution {
    pub fn longest_arith_seq_length(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 2 {
            return n as i32;
        }
        let mut dp = vec![HashMap::new(); n];
        let mut max_len = 2;

        for i in 1..n {
            for j in 0..i {
                let diff = nums[i] - nums[j];
                let len = *dp[j].get(&diff).unwrap_or(&1) + 1;
                dp[i].insert(diff, len);
                max_len = max_len.max(len);
            }
        }

        max_len
    }
}