impl Solution {
    pub fn stone_game_viii(stones: Vec<i32>) -> i32 {
        let n = stones.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + stones[i];
        }

        let mut dp = vec![0; n];
        dp[n - 1] = prefix_sum[n];

        for i in (0..n - 1).rev() {
            dp[i] = (prefix_sum[i + 1] - dp[i + 1]).max(dp[i+1]);
        }

        dp[0]
    }
}