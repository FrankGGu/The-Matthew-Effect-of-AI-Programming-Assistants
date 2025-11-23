impl Solution {
    pub fn num_sub(s: String) -> i32 {
        let mut total_substrings: i64 = 0;
        let mut current_consecutive_ones: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        for c in s.chars() {
            if c == '1' {
                current_consecutive_ones += 1;
            } else {
                current_consecutive_ones = 0;
            }
            total_substrings = (total_substrings + current_consecutive_ones) % modulo;
        }

        total_substrings as i32
    }
}