impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let n = prices.len();
        if n == 0 { return 0; }

        let mut sell = vec![0; n];
        let mut buy = vec![0; n];

        buy[0] = -prices[0];
        for i in 1..n {
            sell[i] = buy[i - 1] + prices[i];
            buy[i] = if i > 1 { sell[i - 2] - prices[i] } else { -prices[i] }.max(buy[i - 1]);
        }

        sell[n - 1].max(0)
    }
}