impl Solution {
    pub fn coin_change(coins: Vec<i32>, amount: i32) -> i32 {
        if amount == 0 {
            return 0;
        }

        let amount_usize = amount as usize;
        let max_val = amount_usize + 1;

        let mut dp = vec![max_val; amount_usize + 1];
        dp[0] = 0;

        for i in 1..=amount_usize {
            for &coin in coins.iter() {
                let coin_usize = coin as usize;
                if i >= coin_usize {
                    dp[i] = dp[i].min(dp[i - coin_usize] + 1);
                }
            }
        }

        if dp[amount_usize] == max_val {
            -1
        } else {
            dp[amount_usize] as i32
        }
    }
}