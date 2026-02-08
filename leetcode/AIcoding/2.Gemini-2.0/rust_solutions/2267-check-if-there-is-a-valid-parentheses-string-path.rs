impl Solution {
    pub fn has_valid_path(grid: Vec<Vec<char>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        if (m + n - 1) % 2 != 0 {
            return false;
        }
        let mut dp = vec![vec![vec![false; m + n]; n]; m];
        if grid[0][0] == '(' {
            dp[0][0][1] = true;
        }
        for i in 0..m {
            for j in 0..n {
                for k in 0..(m + n) {
                    if dp[i][j][k] {
                        let next_k = if grid[i][j] == '(' { k + 1 } else { k - 1 };
                        if next_k >= 0 && next_k < m + n {
                            if i + 1 < m {
                                dp[i + 1][j][next_k] = true;
                            }
                            if j + 1 < n {
                                dp[i][j + 1][next_k] = true;
                            }
                        }
                    }
                }
            }
        }
        dp[m - 1][n - 1][0]
    }
}