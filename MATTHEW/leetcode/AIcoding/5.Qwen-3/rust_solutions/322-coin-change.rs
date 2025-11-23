impl Solution {

use std::cmp;

impl Solution {
    pub fn coin_change(mut coins: Vec<i32>, amount: i32) -> i32 {
        let amount = amount as usize;
        let mut dp = vec![cmp::i32::MAX; amount + 1];
        dp[0] = 0;

        for i in 0..coins.len() {
            let coin = coins[i] as usize;
            for j in coin..=amount {
                if dp[j - coin] != cmp::i32::MAX {
                    dp[j] = cmp::min(dp[j], dp[j - coin] + 1);
                }
            }
        }

        if dp[amount] == cmp::i32::MAX {
            -1
        } else {
            dp[amount]
        }
    }
}

pub struct Solution;
}