impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn buy_chocolates(prices: Vec<i32>, money: i32) -> i32 {
        let mut prices = prices;
        prices.sort();
        if prices[0] + prices[1] <= money {
            money - prices[0] - prices[1]
        } else {
            money
        }
    }
}
}