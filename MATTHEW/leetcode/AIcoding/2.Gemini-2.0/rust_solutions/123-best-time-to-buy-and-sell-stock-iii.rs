impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let n = prices.len();
        if n == 0 {
            return 0;
        }

        let mut dp = vec![vec![0; 5]; n];

        for i in 0..n {
            for j in 0..5 {
                if i == 0 {
                    if j % 2 == 0 {
                        dp[i][j] = 0;
                    } else {
                        dp[i][j] = -prices[i];
                    }
                } else {
                    if j == 0 {
                        dp[i][j] = 0;
                    } else if j % 2 == 0 {
                        dp[i][j] = dp[i - 1][j].max(dp[i - 1][j - 1] + prices[i]);
                    } else {
                        dp[i][j] = dp[i - 1][j].max(dp[i - 1][j - 1] - prices[i]);
                    }
                }
            }
        }

        dp[n - 1][4]
    }
}