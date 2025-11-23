impl Solution {
    pub fn maximum_total_reward(rewards: Vec<i32>) -> i32 {
        let n = rewards.len();
        let mut dp = vec![vec![0; 2]; n + 1];

        for i in 1..=n {
            dp[i][0] = std::cmp::max(dp[i - 1][0], dp[i - 1][1]);
            dp[i][1] = dp[i - 1][0] + rewards[i - 1];
        }

        std::cmp::max(dp[n][0], dp[n][1])
    }
}