impl Solution {
    pub fn max_score(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![std::i32::MIN; n]; m];
        let mut res = std::i32::MIN;

        for i in 0..m {
            for j in 0..n {
                if i == 0 && j == 0 {
                    dp[i][j] = 0;
                    continue;
                }
                let mut max_prev = std::i32::MIN;
                if i > 0 {
                    max_prev = max_prev.max(dp[i - 1][j]);
                }
                if j > 0 {
                    max_prev = max_prev.max(dp[i][j - 1]);
                }
                dp[i][j] = max_prev.max(0) + grid[i][j];
                if i > 0 || j > 0 {
                    res = res.max(dp[i][j] - grid[i][j]);
                }
            }
        }
        res
    }
}