pub fn change(amount: i32, coins: Vec<i32>) -> i32 {
    let mut dp = vec![0; (amount + 1) as usize];
    dp[0] = 1;

    for coin in coins {
        for j in coin..=amount {
            dp[j as usize] += dp[(j - coin) as usize];
        }
    }

    dp[amount as usize]
}