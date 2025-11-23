impl Solution {
    pub fn buy_choco(prices: Vec<i32>, money: i32) -> i32 {
        let mut min1 = i32::MAX;
        let mut min2 = i32::MAX;
        for &price in prices.iter() {
            if price < min1 {
                min2 = min1;
                min1 = price;
            } else if price < min2 {
                min2 = price;
            }
        }
        let total = min1 + min2;
        if total <= money {
            money - total
        } else {
            money
        }
    }
}