impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_value_of_k_coins_from_piles(piles: Vec<Vec<i32>>, k: i32) -> i32 {
        let k = k as usize;
        let mut dp = vec![0; k + 1];

        for pile in piles {
            let mut temp = dp.clone();
            for i in 1..=k {
                for j in 1..=i {
                    if j <= pile.len() {
                        let sum = pile[..j].iter().sum::<i32>();
                        if temp[i] < dp[i - j] + sum {
                            temp[i] = dp[i - j] + sum;
                        }
                    }
                }
            }
            dp = temp;
        }

        dp[k]
    }
}
}