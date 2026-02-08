impl Solution {
    pub fn change(amount: i32, coins: Vec<i32>) -> i32 {
        let amount = amount as usize;
        let n = coins.len();
        let mut dp = vec![0; amount + 1];
        dp[0] = 1;

        for &coin in &coins {
            for i in coin as usize..=amount {
                dp[i] += dp[i - coin as usize];
            }
        }

        dp[amount]
    }
}