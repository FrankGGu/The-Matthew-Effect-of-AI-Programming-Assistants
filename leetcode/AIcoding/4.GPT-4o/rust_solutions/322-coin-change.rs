impl Solution {
    pub fn coin_change(coins: Vec<i32>, amount: i32) -> i32 {
        let mut dp = vec![i32::MAX; (amount + 1) as usize];
        dp[0] = 0;
        for &coin in &coins {
            for j in coin..=amount {
                if dp[j as usize - coin as usize] != i32::MAX {
                    dp[j as usize] = dp[j as usize].min(dp[j as usize - coin as usize] + 1);
                }
            }
        }
        if dp[amount as usize] == i32::MAX {
            -1
        } else {
            dp[amount as usize]
        }
    }
}