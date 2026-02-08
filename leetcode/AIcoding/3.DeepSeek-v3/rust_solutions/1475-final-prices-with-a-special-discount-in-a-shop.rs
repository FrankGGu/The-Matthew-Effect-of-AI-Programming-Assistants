impl Solution {
    pub fn final_prices(prices: Vec<i32>) -> Vec<i32> {
        let mut res = prices.clone();
        for i in 0..prices.len() {
            for j in i + 1..prices.len() {
                if prices[j] <= prices[i] {
                    res[i] -= prices[j];
                    break;
                }
            }
        }
        res
    }
}