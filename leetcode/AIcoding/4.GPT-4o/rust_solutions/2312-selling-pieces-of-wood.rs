impl Solution {
    pub fn maximize_the_profit(n: i32, prices: Vec<i32>) -> i32 {
        let mut dp = vec![0; (n + 1) as usize];
        for i in 1..=n {
            for j in 1..=i {
                if j as usize - 1 < prices.len() {
                    dp[i as usize] = dp[i as usize].max(dp[(i - j) as usize] + prices[j as usize - 1]);
                }
            }
        }
        dp[n as usize]
    }
}