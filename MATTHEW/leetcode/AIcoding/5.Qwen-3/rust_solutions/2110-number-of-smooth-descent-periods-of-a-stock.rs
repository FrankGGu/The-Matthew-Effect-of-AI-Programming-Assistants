struct Solution {}

impl Solution {
    pub fn get_smooth_descents(prices: Vec<i32>) -> i64 {
        if prices.is_empty() {
            return 0;
        }

        let mut count = 1;
        let mut prev = prices[0];

        for &price in &prices[1..] {
            if price < prev {
                count += 1;
            } else {
                count = 1;
            }
            prev = price;
        }

        count
    }
}