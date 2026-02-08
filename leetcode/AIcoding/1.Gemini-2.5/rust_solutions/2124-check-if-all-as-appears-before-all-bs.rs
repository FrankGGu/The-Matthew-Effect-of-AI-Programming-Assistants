impl Solution {
    pub fn check_string(s: String) -> bool {
        let mut seen_b = false;
        for c in s.chars() {
            if c == 'a' {
                if seen_b {
                    return false;
                }
            } else { // c == 'b'
                seen_b = true;
            }
        }
        true
    }
}