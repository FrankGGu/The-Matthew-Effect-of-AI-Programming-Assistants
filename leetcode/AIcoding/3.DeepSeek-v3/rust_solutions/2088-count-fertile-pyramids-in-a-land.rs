impl Solution {
    pub fn count_pyramids(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        if n == 0 {
            return 0;
        }
        let mut dp = grid.clone();
        let mut res = 0;

        for i in (0..m - 1).rev() {
            for j in 1..n - 1 {
                if dp[i][j] == 1 && dp[i + 1][j] >= 1 {
                    dp[i][j] = dp[i + 1][j - 1].min(dp[i + 1][j + 1]) + 1;
                    res += dp[i][j] - 1;
                }
            }
        }

        let mut dp = grid;
        for i in 1..m {
            for j in 1..n - 1 {
                if dp[i][j] == 1 && dp[i - 1][j] >= 1 {
                    dp[i][j] = dp[i - 1][j - 1].min(dp[i - 1][j + 1]) + 1;
                    res += dp[i][j] - 1;
                }
            }
        }

        res
    }
}