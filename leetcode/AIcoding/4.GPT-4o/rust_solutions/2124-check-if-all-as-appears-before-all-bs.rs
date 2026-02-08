impl Solution {
    pub fn check_string(s: String) -> bool {
        let mut found_b = false;
        for c in s.chars() {
            if c == 'b' {
                found_b = true;
            } else if found_b && c == 'a' {
                return false;
            }
        }
        true
    }
}