impl Solution {
    pub fn stone_game_viii(stones: Vec<i32>) -> i32 {
        let n = stones.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + stones[i];
        }

        let mut dp = vec![0; n];
        dp[n - 1] = prefix[n];

        for i in (1..n - 1).rev() {
            dp[i] = std::cmp::max(dp[i + 1], prefix[i + 1] - dp[i + 1]);
        }

        dp[1]
    }
}