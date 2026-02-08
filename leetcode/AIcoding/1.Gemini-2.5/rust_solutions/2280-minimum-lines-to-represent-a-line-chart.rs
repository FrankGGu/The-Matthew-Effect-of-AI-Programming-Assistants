impl Solution {
    pub fn minimum_lines(mut stock_prices: Vec<Vec<i32>>) -> i32 {
        let n = stock_prices.len();

        if n <= 1 {
            return 0;
        }

        stock_prices.sort_unstable_by_key(|p| p[0]);

        let mut lines = 1;

        // Initialize the slope from the first two points.
        // Use i64 for calculations to prevent overflow, as coordinates can be large.
        let mut prev_dx = (stock_prices[1][0] - stock_prices[0][0]) as i64;
        let mut prev_dy = (stock_prices[1][1] - stock_prices[0][1]) as i64;

        // Iterate from the third point to check for collinearity.
        // Points are stock_prices[i-2], stock_prices[i-1], stock_prices[i]
        // We compare the slope of (stock_prices[i-2] -> stock_prices[i-1])
        // with the slope of (stock_prices[i-1] -> stock_prices[i]).
        for i in 2..n {
            let p_prev_x = stock_prices[i-1][0] as i64;
            let p_prev_y = stock_prices[i-1][1] as i64;
            let p_curr_x = stock_prices[i][0] as i64;
            let p_curr_y = stock_prices[i][1] as i64;

            let current_dx = p_curr_x - p_prev_x;
            let current_dy = p_curr_y - p_prev_y;

            // Check for collinearity using cross-multiplication to avoid floating point issues and division by zero.
            // (y2 - y1) / (x2 - x1) == (y3 - y2) / (x3 - x2)
            // is equivalent to
            // (y2 - y1) * (x3 - x2) == (y3 - y2) * (x2 - x1)
            // Here, (x2-x1) is prev_dx, (y2-y1) is prev_dy
            // (x3-x2) is current_dx, (y3-y2) is current_dy
            if prev_dy * current_dx != current_dy * prev_dx {
                lines += 1;
            }

            // Update prev_dx and prev_dy to represent the slope of the segment ending at stock_prices[i]
            // for the next iteration's comparison.
            prev_dx = current_dx;
            prev_dy = current_dy;
        }

        lines
    }
}