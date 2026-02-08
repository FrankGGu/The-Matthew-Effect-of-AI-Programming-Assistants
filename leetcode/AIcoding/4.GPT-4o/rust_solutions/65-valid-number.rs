impl Solution {
    pub fn is_number(s: String) -> bool {
        let s = s.trim();
        let mut seen_digit = false;
        let mut seen_dot = false;
        let mut seen_e = false;
        let mut seen_sign = false;

        for (i, c) in s.chars().enumerate() {
            if c.is_digit(10) {
                seen_digit = true;
            } else if c == '.' {
                if seen_dot || seen_e {
                    return false;
                }
                seen_dot = true;
            } else if c == 'e' || c == 'E' {
                if seen_e || !seen_digit {
                    return false;
                }
                seen_e = true;
                seen_digit = false; // Reset for digits after 'e'
            } else if c == '+' || c == '-' {
                if seen_sign || (i > 0 && s.chars().nth(i - 1) != Some('e') && s.chars().nth(i - 1) != Some('E')) {
                    return false;
                }
                seen_sign = true;
            } else {
                return false;
            }
        }
        seen_digit
    }
}