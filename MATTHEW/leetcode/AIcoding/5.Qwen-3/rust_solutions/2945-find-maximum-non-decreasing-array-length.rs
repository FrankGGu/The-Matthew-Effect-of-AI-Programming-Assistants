impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_len_of_non_decreasing_array(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        let mut dp = vec![1; n];
        for i in 1..n {
            for j in 0..i {
                if nums[j] <= nums[i] {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
        }
        *dp.iter().max().unwrap() as i32
    }
}
}