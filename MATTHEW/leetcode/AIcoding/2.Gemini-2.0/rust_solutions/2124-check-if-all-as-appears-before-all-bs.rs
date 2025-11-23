impl Solution {
    pub fn check_string(s: String) -> bool {
        let mut b_found = false;
        for c in s.chars() {
            if c == 'b' {
                b_found = true;
            } else if b_found {
                return false;
            }
        }
        true
    }
}