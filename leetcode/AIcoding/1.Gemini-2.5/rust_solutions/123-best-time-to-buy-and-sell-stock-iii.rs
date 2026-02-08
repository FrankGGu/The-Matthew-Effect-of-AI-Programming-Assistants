impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let mut t1_buy = std::i32::MIN;
        let mut t1_sell = 0;
        let mut t2_buy = std::i32::MIN;
        let mut t2_sell = 0;

        for price in prices {
            t2_sell = t2_sell.max(t2_buy + price);
            t2_buy = t2_buy.max(t1_sell - price);
            t1_sell = t1_sell.max(t1_buy + price);
            t1_buy = t1_buy.max(-price);
        }

        t2_sell
    }
}