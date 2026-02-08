impl Solution {
    pub fn minimum_lines(stock_prices: Vec<Vec<i32>>) -> i32 {
        if stock_prices.len() <= 1 {
            return 0;
        }

        let mut prices = stock_prices;
        prices.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut lines = 1;
        for i in 2..prices.len() {
            let x1 = prices[i - 2][0] as i64;
            let y1 = prices[i - 2][1] as i64;
            let x2 = prices[i - 1][0] as i64;
            let y2 = prices[i - 1][1] as i64;
            let x3 = prices[i][0] as i64;
            let y3 = prices[i][1] as i64;

            if (y2 - y1) * (x3 - x2) != (y3 - y2) * (x2 - x1) {
                lines += 1;
            }
        }

        lines
    }
}