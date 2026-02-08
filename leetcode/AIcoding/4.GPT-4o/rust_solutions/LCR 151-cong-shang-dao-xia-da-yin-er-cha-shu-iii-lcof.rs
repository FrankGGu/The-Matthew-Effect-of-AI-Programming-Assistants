pub fn maximum_brightness(grid: Vec<Vec<i32>>) -> i32 {
    let n = grid.len();
    let m = grid[0].len();
    let mut dp = vec![vec![0; m + 1]; n + 1];

    for i in 1..=n {
        for j in 1..=m {
            dp[i][j] = dp[i - 1][j].max(dp[i][j - 1]) + grid[i - 1][j - 1];
        }
    }

    dp[n][m]
}