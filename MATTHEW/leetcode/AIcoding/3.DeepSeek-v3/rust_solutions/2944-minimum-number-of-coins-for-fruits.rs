impl Solution {
    pub fn minimum_coins(prices: Vec<i32>) -> i32 {
        let n = prices.len();
        let mut dp = vec![i32::MAX; n + 2];
        dp[n] = 0;
        for i in (0..n).rev() {
            let max_j = std::cmp::min(n, i + i + 2);
            for j in i + 1..=max_j {
                if dp[j] != i32::MAX {
                    dp[i] = std::cmp::min(dp[i], prices[i] + dp[j]);
                }
            }
        }
        dp[0]
    }
}