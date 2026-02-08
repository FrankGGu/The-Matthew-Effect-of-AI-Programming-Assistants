impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![i32::MAX / 2; 2]; n + 1];
        dp[0][0] = 0;
        dp[0][1] = 1;

        for i in 0..n {
            if nums[i] == 1 {
                dp[i + 1][0] = dp[i][0];
                dp[i + 1][1] = dp[i][1] + 1;
            } else {
                dp[i + 1][0] = dp[i][1];
                if i > 0 {
                    dp[i + 1][1] = std::cmp::min(dp[i][0] + 1, dp[i - 1][0] + 1);
                } else {
                    dp[i + 1][1] = dp[i][0] + 1;
                }
            }
        }

        std::cmp::min(dp[n][0], dp[n][1])
    }
}