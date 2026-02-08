impl Solution {
    pub fn get_descent_periods(prices: Vec<i32>) -> i64 {
        let n = prices.len();
        let mut ans: i64 = 0;
        let mut len: i64 = 1;
        for i in 1..n {
            if prices[i] == prices[i - 1] - 1 {
                len += 1;
            } else {
                ans += len * (len + 1) / 2;
                len = 1;
            }
        }
        ans += len * (len + 1) / 2;
        ans
    }
}