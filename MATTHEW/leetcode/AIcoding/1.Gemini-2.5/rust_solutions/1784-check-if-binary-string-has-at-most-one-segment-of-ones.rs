impl Solution {
    pub fn check_ones_segment(s: String) -> bool {
        let mut found_one = false;
        let mut found_zero_after_one = false;

        for c in s.chars() {
            if c == '1' {
                if found_zero_after_one {
                    return false;
                }
                found_one = true;
            } else { // c == '0'
                if found_one {
                    found_zero_after_one = true;
                }
            }
        }

        true
    }
}