impl Solution {
    pub fn best_closing_time(customers: String) -> i32 {
        let mut penalty = 0;
        let mut min_penalty = i32::MAX;
        let mut min_time = 0;

        for (i, ch) in customers.chars().enumerate() {
            if ch == 'Y' {
                penalty += 1;
            }
            if penalty + (customers.len() - i - 1) < min_penalty {
                min_penalty = penalty + (customers.len() - i - 1);
                min_time = (i + 1) as i32;
            }
        }

        min_time
    }
}