impl Solution {
    pub fn change(amount: i32, coins: Vec<i32>) -> i32 {
        let amount = amount as usize;
        let mut dp = vec![0; amount + 1];
        dp[0] = 1;

        for coin in coins {
            let coin = coin as usize;
            for j in coin..=amount {
                dp[j] += dp[j - coin];
            }
        }

        dp[amount]
    }
}