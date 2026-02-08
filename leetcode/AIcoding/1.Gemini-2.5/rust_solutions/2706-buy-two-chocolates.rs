impl Solution {
    pub fn buy_choco(mut prices: Vec<i32>, money: i32) -> i32 {
        prices.sort_unstable();
        let min_cost = prices[0] + prices[1];
        if min_cost <= money {
            money - min_cost
        } else {
            money
        }
    }
}