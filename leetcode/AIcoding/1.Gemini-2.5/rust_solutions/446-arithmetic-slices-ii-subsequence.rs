use std::collections::HashMap;

impl Solution {
    pub fn number_of_arithmetic_slices(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 3 {
            return 0;
        }

        let mut dp: Vec<HashMap<i64, i32>> = vec![HashMap::new(); n];
        let mut total_count = 0;

        for i in 0..n {
            for j in 0..i {
                let diff = nums[i] as i64 - nums[j] as i64;

                *dp[i].entry(diff).or_insert(0) += 1;

                if let Some(&count_j) = dp[j].get(&diff) {
                    total_count += count_j;
                    *dp[i].entry(diff).or_insert(0) += count_j;
                }
            }
        }

        total_count
    }
}