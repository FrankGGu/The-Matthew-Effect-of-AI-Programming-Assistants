impl Solution {
    pub fn max_profit(k: i32, prices: Vec<i32>) -> i32 {
        if prices.is_empty() || k == 0 {
            return 0;
        }
        let n = prices.len();
        if k as usize >= n / 2 {
            return prices.windows(2).map(|w| (w[1] - w[0]).max(0)).sum();
        }

        let mut dp = vec![vec![0; n]; k as usize + 1];

        for i in 1..=k as usize {
            let mut max_diff = -prices[0];
            for j in 1..n {
                dp[i][j] = dp[i][j - 1].max(prices[j] + max_diff);
                max_diff = max_diff.max(dp[i - 1][j] - prices[j]);
            }
        }

        dp[k as usize][n - 1]
    }
}