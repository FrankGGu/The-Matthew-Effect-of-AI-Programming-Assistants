impl Solution {
    pub fn final_prices(prices: Vec<i32>) -> Vec<i32> {
        let n = prices.len();
        let mut result = prices.clone();
        for i in 0..n {
            for j in i + 1..n {
                if prices[j] <= prices[i] {
                    result[i] = prices[i] - prices[j];
                    break;
                }
            }
        }
        result
    }
}