impl Solution {
    pub fn maximum_profit(prices: Vec<i32>, discounts: Vec<i32>, k: i32) -> i64 {
        let n = prices.len();
        let mut dp = vec![vec![0i64; (k + 1) as usize]; n + 1];

        for i in (0..n).rev() {
            for j in 0..=k as usize {
                dp[i][j] = dp[i + 1][j]; 
                if j > 0 {
                    dp[i][j] = dp[i][j].max(dp[i + 1][j - 1] + (prices[i] - discounts[i]) as i64);
                }
                dp[i][j] = dp[i][j].max(prices[i] as i64 + dp[i + 1][j]);
            }
        }

        dp[0][k as usize]
    }
}