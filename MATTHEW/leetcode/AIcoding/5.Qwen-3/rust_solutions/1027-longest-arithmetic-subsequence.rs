impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_arith_seq_subseq(nums: Vec<i32>, target: i32) -> i32 {
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        let mut dp = vec![HashMap::new(); n];
        let mut max_len = 0;

        for i in 0..n {
            for j in 0..i {
                let diff = nums[i] - nums[j];
                let count = *dp[j].get(&diff).unwrap_or(&1);
                dp[i].insert(diff, count + 1);
                max_len = max_len.max(count + 1);
            }
        }

        max_len
    }
}
}