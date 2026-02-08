impl Solution {
    pub fn max_profit(prices: Vec<i32>, discounts: Vec<i32>) -> i32 {
        let n = prices.len();
        let m = discounts.len();
        let mut dp = vec![vec![0; m + 1]; n + 1];

        for i in 1..=n {
            for j in 0..=m {
                dp[i][j] = dp[i - 1][j];
                if j > 0 {
                    let discount = discounts[j - 1];
                    let price = prices[i - 1];
                    let profit = price - discount;
                    if profit > 0 {
                        dp[i][j] = dp[i][j].max(dp[i - 1][j - 1] + profit);
                    }
                }
            }
        }

        dp[n][m]
    }
}