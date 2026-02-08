impl Solution {
    pub fn maximum_items(prices: Vec<i32>, k: i32) -> i32 {
        let mut prices = prices;
        prices.sort();
        let mut total = 0;
        let mut count = 0;

        for price in prices {
            if total + price <= k {
                total += price;
                count += 1;
            } else {
                break;
            }
        }

        count
    }
}