impl Solution {
    pub fn count_homogenous(s: String) -> i32 {
        let mut total_count: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        let mut current_char: Option<char> = None;
        let mut current_len: i64 = 0;

        for c in s.chars() {
            if let Some(prev_char) = current_char {
                if c == prev_char {
                    current_len += 1;
                } else {
                    current_char = Some(c);
                    current_len = 1;
                }
            } else {
                // First character encountered
                current_char = Some(c);
                current_len = 1;
            }
            total_count = (total_count + current_len) % modulo;
        }

        total_count as i32
    }
}