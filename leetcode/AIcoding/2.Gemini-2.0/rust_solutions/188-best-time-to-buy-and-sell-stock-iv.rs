impl Solution {
    pub fn max_profit(k: i32, prices: Vec<i32>) -> i32 {
        let n = prices.len();
        if n <= 1 {
            return 0;
        }

        let k = k as usize;

        if k >= n / 2 {
            let mut profit = 0;
            for i in 1..n {
                if prices[i] > prices[i - 1] {
                    profit += prices[i] - prices[i - 1];
                }
            }
            return profit;
        }

        let mut buy = vec![i32::MIN; k + 1];
        let mut sell = vec![0; k + 1];

        for i in 0..n {
            for j in 1..=k {
                buy[j] = buy[j].max(sell[j - 1] - prices[i]);
                sell[j] = sell[j].max(buy[j] + prices[i]);
            }
        }

        sell[k]
    }
}