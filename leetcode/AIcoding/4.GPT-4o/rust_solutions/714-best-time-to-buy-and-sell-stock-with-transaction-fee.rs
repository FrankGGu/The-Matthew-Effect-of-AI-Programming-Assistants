impl Solution {
    pub fn max_profit(prices: Vec<i32>, fee: i32) -> i32 {
        let mut cash = 0;
        let mut hold = i32::MIN;

        for &price in &prices {
            cash = cash.max(hold + price - fee);
            hold = hold.max(cash - price);
        }

        cash
    }
}