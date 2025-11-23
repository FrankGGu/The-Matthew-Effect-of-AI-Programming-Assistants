impl Solution {
    pub fn smooth_descent_periods(prices: Vec<i32>) -> i64 {
        let mut total_periods: i64 = 0;
        let mut current_length: i64 = 0;

        for i in 0..prices.len() {
            if i == 0 || prices[i - 1] - prices[i] == 1 {
                current_length += 1;
            } else {
                total_periods += current_length * (current_length + 1) / 2;
                current_length = 1;
            }
        }

        total_periods += current_length * (current_length + 1) / 2;

        total_periods
    }
}