impl Solution {
    pub fn is_number(s: String) -> bool {
        let s = s.trim();
        let mut seen_digit = false;
        let mut seen_exponent = false;
        let mut seen_dot = false;

        for (i, c) in s.chars().enumerate() {
            match c {
                '0'..='9' => {
                    seen_digit = true;
                }
                '.' => {
                    if seen_dot || seen_exponent {
                        return false;
                    }
                    seen_dot = true;
                }
                'e' | 'E' => {
                    if seen_exponent || !seen_digit {
                        return false;
                    }
                    seen_exponent = true;
                    seen_digit = false;
                }
                '+' | '-' => {
                    if i != 0 && s.chars().nth(i - 1) != Some('e') && s.chars().nth(i - 1) != Some('E') {
                        return false;
                    }
                    if i == s.len() - 1 {
                        return false;
                    }
                }
                _ => {
                    return false;
                }
            }
        }

        seen_digit
    }
}