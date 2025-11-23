struct Solution;

impl Solution {
    pub fn count_keys(s: String) -> i32 {
        let mut count = 0;
        let mut prev_char = ' ';
        for c in s.chars() {
            if c != prev_char {
                count += 1;
                prev_char = c;
            }
        }
        count
    }
}