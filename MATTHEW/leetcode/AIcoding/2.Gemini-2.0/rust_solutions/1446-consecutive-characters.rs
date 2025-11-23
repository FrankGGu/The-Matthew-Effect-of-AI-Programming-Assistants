impl Solution {
    pub fn max_power(s: String) -> i32 {
        let mut max_len = 0;
        let mut current_len = 0;
        let mut current_char = ' ';

        for c in s.chars() {
            if c == current_char {
                current_len += 1;
            } else {
                max_len = max_len.max(current_len);
                current_len = 1;
                current_char = c;
            }
        }

        max_len.max(current_len)
    }
}