use std::collections::HashMap;

impl Solution {
    pub fn number_of_arithmetic_slices(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![HashMap::new(); n];
        let mut res = 0;

        for i in 1..n {
            for j in 0..i {
                let diff = nums[i] as i64 - nums[j] as i64;
                let count = *dp[j].get(&diff).unwrap_or(&0);
                res += count;
                *dp[i].entry(diff).or_insert(0) += count + 1;
            }
        }

        res
    }
}