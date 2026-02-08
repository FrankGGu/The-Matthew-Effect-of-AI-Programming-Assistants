pub fn max_profit(prices: Vec<i32>, fee: i32) -> i32 {
    let n = prices.len();
    let mut dp = vec![0; n + 1];
    let mut hold = -prices[0] - fee;

    for i in 1..n {
        dp[i + 1] = dp[i];
        hold = hold.max(dp[i] - prices[i] - fee);
        dp[i + 1] = dp[i + 1].max(hold + prices[i]);
    }

    dp[n]
}