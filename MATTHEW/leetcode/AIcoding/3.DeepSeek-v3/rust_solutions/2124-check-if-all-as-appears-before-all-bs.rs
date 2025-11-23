impl Solution {
    pub fn check_string(s: String) -> bool {
        let mut seen_b = false;
        for c in s.chars() {
            if c == 'b' {
                seen_b = true;
            } else if seen_b && c == 'a' {
                return false;
            }
        }
        true
    }
}