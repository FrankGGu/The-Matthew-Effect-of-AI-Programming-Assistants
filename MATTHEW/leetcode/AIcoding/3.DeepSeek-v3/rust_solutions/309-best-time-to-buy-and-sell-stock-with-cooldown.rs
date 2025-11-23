impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let n = prices.len();
        if n < 2 {
            return 0;
        }

        let mut dp = vec![vec![0; 3]; n];
        dp[0][0] = -prices[0];

        for i in 1..n {
            dp[i][0] = dp[i-1][0].max(dp[i-1][2] - prices[i]);
            dp[i][1] = dp[i-1][0] + prices[i];
            dp[i][2] = dp[i-1][1].max(dp[i-1][2]);
        }

        dp[n-1][1].max(dp[n-1][2])
    }
}