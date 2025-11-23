impl Solution {
    pub fn buy_choco(prices: Vec<i32>, money: i32) -> i32 {
        let mut prices = prices;
        prices.sort();
        if prices.len() < 2 {
            return money;
        }
        let total_cost = prices[0] + prices[1];
        if total_cost <= money {
            money - total_cost
        } else {
            money
        }
    }
}