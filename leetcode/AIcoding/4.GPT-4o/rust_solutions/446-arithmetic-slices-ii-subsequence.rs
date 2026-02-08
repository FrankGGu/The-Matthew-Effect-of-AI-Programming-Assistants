use std::collections::HashMap;

impl Solution {
    pub fn number_of_arithmetic_slices(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        let mut dp: Vec<HashMap<i32, i32>> = vec![HashMap::new(); n];

        for i in 0..n {
            for j in 0..i {
                let diff = nums[i] - nums[j];
                let mut curr_count = dp[j].get(&diff).unwrap_or(&0);
                count += curr_count;
                *dp[i].entry(diff).or_insert(0) += curr_count + 1;
            }
        }

        count
    }
}