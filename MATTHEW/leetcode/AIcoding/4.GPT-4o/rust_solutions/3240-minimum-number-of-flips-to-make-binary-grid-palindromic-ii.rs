impl Solution {
    pub fn min_flips_palindrome(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut dp = vec![vec![vec![i32::MAX; 2]; m + 1]; n + 1];

        dp[0][0][0] = 0;

        for i in 0..=n {
            for j in 0..=m {
                for k in 0..=1 {
                    if i < n && j < m {
                        let flip = grid[i][j] ^ k;
                        let new_k = flip ^ 1;
                        let flips_needed = flip as i32;
                        dp[i + 1][j][k] = dp[i + 1][j][k].min(dp[i][j][k] + flips_needed);
                        if j + 1 < m {
                            dp[i][j + 1][k] = dp[i][j + 1][k].min(dp[i][j][k] + flips_needed);
                        }
                        if i + 1 < n {
                            let next_flip = grid[n - 1 - i][m - 1 - j] ^ k;
                            let next_flips_needed = next_flip as i32;
                            dp[i + 1][j][new_k] = dp[i + 1][j][new_k].min(dp[i][j][k] + next_flips_needed);
                        }
                    }
                }
            }
        }

        dp[n][m][0].min(dp[n][m][1])
    }
}