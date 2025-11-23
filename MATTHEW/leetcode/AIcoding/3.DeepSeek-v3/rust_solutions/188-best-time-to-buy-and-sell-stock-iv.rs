impl Solution {
    pub fn max_profit(k: i32, prices: Vec<i32>) -> i32 {
        let n = prices.len();
        if n == 0 || k == 0 {
            return 0;
        }
        let k = k as usize;
        if k >= n / 2 {
            let mut max_profit = 0;
            for i in 1..n {
                if prices[i] > prices[i - 1] {
                    max_profit += prices[i] - prices[i - 1];
                }
            }
            return max_profit;
        }
        let mut buy = vec![std::i32::MIN; k + 1];
        let mut sell = vec![0; k + 1];
        for price in prices {
            for i in 1..=k {
                buy[i] = buy[i].max(sell[i - 1] - price);
                sell[i] = sell[i].max(buy[i] + price);
            }
        }
        sell[k]
    }
}