pub fn max_coins(coins: Vec<i32>, bonus: i32) -> i32 {
    let mut dp = vec![0; (bonus + 1) as usize];
    for &coin in &coins {
        for j in (coin..=bonus).rev() {
            dp[j as usize] = dp[j as usize].max(dp[(j - coin) as usize] + coin);
        }
    }
    dp[bonus as usize]
}