impl Solution {
    pub fn get_descent_periods(prices: Vec<i32>) -> i64 {
        let mut res = 0;
        let mut current = 1;
        for i in 1..prices.len() {
            if prices[i] == prices[i - 1] - 1 {
                current += 1;
            } else {
                res += (current * (current + 1)) / 2;
                current = 1;
            }
        }
        res += (current * (current + 1)) / 2;
        res
    }
}