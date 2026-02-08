impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let n = prices.len();
        if n < 2 {
            return 0;
        }

        let mut buy1 = -prices[0];
        let mut sell1 = 0;
        let mut buy2 = -prices[0];
        let mut sell2 = 0;

        for i in 1..n {
            buy1 = buy1.max(-prices[i]);
            sell1 = sell1.max(buy1 + prices[i]);
            buy2 = buy2.max(sell1 - prices[i]);
            sell2 = sell2.max(buy2 + prices[i]);
        }

        sell2
    }
}