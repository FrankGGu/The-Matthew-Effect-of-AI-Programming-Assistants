struct Solution;

impl Solution {
    pub fn max_power(s: String) -> i32 {
        if s.is_empty() {
            return 0;
        }

        let mut max_count = 1;
        let mut current_count = 1;

        for i in 1..s.len() {
            if s.as_bytes()[i] == s.as_bytes()[i - 1] {
                current_count += 1;
                if current_count > max_count {
                    max_count = current_count;
                }
            } else {
                current_count = 1;
            }
        }

        max_count
    }
}