impl Solution {

use std::cmp::min;

impl Solution {
    pub fn minimum_money(transactions: Vec<Vec<i32>>) -> i32 {
        let mut min_money = 0;
        let mut total_loss = 0;

        for t in transactions {
            let price = t[0];
            let fee = t[1];

            if price > fee {
                total_loss += price - fee;
            } else {
                min_money = min(min_money, price);
            }
        }

        min_money + total_loss
    }
}
}