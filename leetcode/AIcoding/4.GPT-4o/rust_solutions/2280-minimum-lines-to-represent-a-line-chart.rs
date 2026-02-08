use std::vec::Vec;

impl Solution {
    pub fn minimum_lines(stock_prices: Vec<Vec<i32>>) -> i32 {
        if stock_prices.len() < 2 {
            return 0;
        }
        let mut stock_prices = stock_prices;
        stock_prices.sort_unstable_by_key(|x| x[0]);
        let mut lines = 0;
        let mut prev = stock_prices[0];
        let mut curr = stock_prices[1];

        for i in 2..stock_prices.len() {
            let next = stock_prices[i];
            if (curr[1] - prev[1]) * (next[0] - curr[0]) != (next[1] - curr[1]) * (curr[0] - prev[0]) {
                lines += 1;
            }
            prev = curr;
            curr = next;
        }
        lines
    }
}