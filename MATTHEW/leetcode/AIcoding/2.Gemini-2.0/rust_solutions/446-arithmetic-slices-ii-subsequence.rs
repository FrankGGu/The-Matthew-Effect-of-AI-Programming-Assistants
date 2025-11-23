use std::collections::HashMap;

impl Solution {
    pub fn number_of_arithmetic_slices(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp: Vec<HashMap<i64, i32>> = vec![HashMap::new(); n];
        let mut total_count = 0;

        for i in 0..n {
            for j in 0..i {
                let diff = nums[i] as i64 - nums[j] as i64;

                if diff > i32::MAX as i64 || diff < i32::MIN as i64 {
                    continue;
                }

                let count_j = dp[j].get(&diff).cloned().unwrap_or(0);
                total_count += count_j;

                let count_i = dp[i].get(&diff).cloned().unwrap_or(0);
                dp[i].insert(diff, count_i + count_j + 1);
            }
        }

        total_count
    }
}