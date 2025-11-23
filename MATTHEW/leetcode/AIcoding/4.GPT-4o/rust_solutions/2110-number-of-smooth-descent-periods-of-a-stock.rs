impl Solution {
    pub fn get_descent_periods(prices: Vec<i32>) -> i64 {
        let mut count = 0;
        let mut total_periods = 0;

        for i in 0..prices.len() {
            if i == 0 || prices[i] + 1 != prices[i - 1] {
                count = 1;
            } else {
                count += 1;
            }
            total_periods += count;
        }
        total_periods
    }
}