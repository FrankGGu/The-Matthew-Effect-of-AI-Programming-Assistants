pub fn max_profit(prices: Vec<i32>) -> i32 {
    let n = prices.len();
    if n == 0 { return 0; }
    let mut dp = vec![vec![vec![0; 3]; n + 1]; 2];

    for i in 1..=n {
        for j in 1..=2 {
            dp[0][i][j] = dp[0][i - 1][j];
            dp[1][i][j] = dp[1][i - 1][j];
            dp[0][i][j] = dp[0][i][j].max(dp[1][i - 1][j - 1] + prices[i - 1]);
            dp[1][i][j] = dp[1][i][j].max(dp[0][i - 1][j] - prices[i - 1]);
        }
    }
    dp[0][n][2]
}