impl Solution {
    pub fn stone_game_ii(piles: Vec<i32>) -> i32 {
        let n = piles.len();
        let mut dp = vec![vec![0; n + 1]; n + 1];
        let mut prefix_sum = vec![0; n + 1];

        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + piles[i];
        }

        for i in (0..n).rev() {
            for m in 1..=n {
                if i + 2 * m >= n {
                    dp[i][m] = prefix_sum[n] - prefix_sum[i];
                } else {
                    for x in 1..=2 * m {
                        dp[i][m] = dp[i][m].max(prefix_sum[i + x] - prefix_sum[i] - dp[i + x][x]);
                    }
                }
            }
        }

        dp[0][1]
    }
}