impl Solution {
    pub fn best_closing_time(customers: String) -> i32 {
        let n = customers.len();
        let customer_bytes = customers.as_bytes();

        let mut current_penalty = 0;
        for &c in customer_bytes {
            if c == b'Y' {
                current_penalty += 1;
            }
        }

        let mut min_penalty = current_penalty;
        let mut best_hour = 0;

        for j in 0..n {
            if customer_bytes[j] == b'Y' {
                current_penalty -= 1;
            } else {
                current_penalty += 1;
            }

            if current_penalty < min_penalty {
                min_penalty = current_penalty;
                best_hour = j + 1;
            }
        }

        best_hour as i32
    }
}