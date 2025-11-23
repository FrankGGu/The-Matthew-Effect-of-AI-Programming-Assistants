impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let n = prices.len();
        if n < 2 {
            return 0;
        }

        let mut dp = vec![vec![0; 3]; n];
        for j in 1..3 {
            let mut max_diff = -prices[0];
            for i in 1..n {
                dp[i][j] = dp[i - 1][j].max(prices[i] + max_diff);
                max_diff = max_diff.max(dp[i - 1][j - 1] - prices[i]);
            }
        }
        dp[n - 1][2]
    }
}