impl Solution {
    pub fn sorting_three_groups(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![0; 4]; n + 1];

        for i in 1..=n {
            for j in 1..=3 {
                dp[i][j] = dp[i - 1][j];
                if nums[i - 1] == j as i32 {
                    dp[i][j] += 1;
                }
            }
            for j in 2..=3 {
                dp[i][j] = dp[i][j].max(dp[i][j - 1]);
            }
        }

        n as i32 - dp[n][3]
    }
}