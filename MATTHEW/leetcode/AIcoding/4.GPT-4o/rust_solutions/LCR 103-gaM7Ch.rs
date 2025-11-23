impl Solution {
    pub fn coin_change(coins: Vec<i32>, amount: i32) -> i32 {
        let mut dp = vec![i32::MAX; (amount + 1) as usize];
        dp[0] = 0;

        for &coin in &coins {
            for x in coin..=amount {
                if dp[(x - coin) as usize] != i32::MAX {
                    dp[x as usize] = dp[x as usize].min(dp[(x - coin) as usize] + 1);
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