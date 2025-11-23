impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_coins(bags: Vec<i32>, k: i32) -> i32 {
        let n = bags.len();
        let k = k as usize;
        let mut max_coins = 0;
        let mut current_sum = 0;

        for i in 0..k {
            current_sum += bags[i];
        }

        max_coins = current_sum;

        for i in k..n {
            current_sum += bags[i] - bags[i - k];
            max_coins = max(max_coins, current_sum);
        }

        max_coins
    }
}
}