impl Solution {
    pub fn max_profit(prices: Vec<i32>, fee: i32) -> i32 {
        let mut cash = 0;
        let mut hold = -prices[0];

        for i in 1..prices.len() {
            cash = cash.max(hold + prices[i] - fee);
            hold = hold.max(cash - prices[i]);
        }

        cash
    }
}