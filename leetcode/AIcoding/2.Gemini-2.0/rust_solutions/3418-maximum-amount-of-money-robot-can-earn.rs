impl Solution {
    pub fn max_money(n: i32, money: Vec<i32>) -> i64 {
        let n = n as usize;
        let mut dp = vec![0; n + 1];
        for i in 1..=n {
            dp[i] = dp[i - 1];
            for j in 1..=i {
                dp[i] = dp[i].max(dp[i - j] + money[j - 1] as i64);
            }
        }
        dp[n]
    }
}