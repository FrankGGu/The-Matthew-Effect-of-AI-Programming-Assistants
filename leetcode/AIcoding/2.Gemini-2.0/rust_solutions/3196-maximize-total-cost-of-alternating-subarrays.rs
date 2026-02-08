impl Solution {
    pub fn maximize_total_cost(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut dp = vec![vec![0; 2]; n + 1];

        for i in 1..=n {
            dp[i][0] = dp[i - 1][0];
            dp[i][1] = dp[i - 1][1];

            if i > 1 {
                if nums[i - 1] > nums[i - 2] {
                    dp[i][1] = dp[i][1].max(dp[i - 2][0] + nums[i - 1] - nums[i - 2] as i64);
                } else if nums[i - 1] < nums[i - 2] {
                    dp[i][0] = dp[i][0].max(dp[i - 2][1] + nums[i - 2] - nums[i - 1] as i64);
                }
            }
        }

        dp[n][0].max(dp[n][1])
    }
}