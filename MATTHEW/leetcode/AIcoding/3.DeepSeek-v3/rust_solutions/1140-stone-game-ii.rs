impl Solution {
    pub fn stone_game_ii(piles: Vec<i32>) -> i32 {
        let n = piles.len();
        let mut dp = vec![vec![0; n + 1]; n];
        let mut suffix_sum = vec![0; n + 1];
        for i in (0..n).rev() {
            suffix_sum[i] = suffix_sum[i + 1] + piles[i];
        }
        for i in (0..n).rev() {
            for m in 1..=n {
                if i + 2 * m >= n {
                    dp[i][m] = suffix_sum[i];
                } else {
                    for x in 1..=2 * m {
                        if i + x > n {
                            break;
                        }
                        dp[i][m] = dp[i][m].max(suffix_sum[i] - dp[i + x][std::cmp::max(m, x)]);
                    }
                }
            }
        }
        dp[0][1]
    }
}