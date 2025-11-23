struct Solution;

impl Solution {
    pub fn check_ones_segment(s: String) -> bool {
        let mut found_one = false;
        for c in s.chars() {
            if c == '1' {
                found_one = true;
            } else if found_one {
                return false;
            }
        }
        true
    }
}