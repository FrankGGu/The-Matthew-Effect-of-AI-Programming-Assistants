impl Solution {
    pub fn min_cost(colors: String, needed_time: Vec<i32>) -> i32 {
        let mut total_cost = 0;
        let mut max_time = 0;
        let mut prev_color = colors.chars().nth(0).unwrap();

        for (i, (c, t)) in colors.chars().zip(needed_time).enumerate() {
            if c == prev_color {
                total_cost += t.min(max_time);
                max_time = max_time.max(t);
            } else {
                max_time = t;
                prev_color = c;
            }
        }
        total_cost
    }
}