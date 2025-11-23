impl Solution {
    pub fn best_closing_time(customers: String) -> i32 {
        let mut min_penalty = i32::MAX;
        let mut best_time = 0;
        let mut current_penalty = 0;

        for (i, c) in customers.chars().enumerate() {
            if c == 'N' {
                current_penalty += 1;
            }

            if current_penalty < min_penalty {
                min_penalty = current_penalty;
                best_time = (i + 1) as i32;
            }
        }

        current_penalty = 0;
        for c in customers.chars() {
            if c == 'Y' {
                current_penalty += 1;
            }
        }

        if current_penalty < min_penalty {
            min_penalty = current_penalty;
            best_time = 0;
        }

        best_time
    }
}