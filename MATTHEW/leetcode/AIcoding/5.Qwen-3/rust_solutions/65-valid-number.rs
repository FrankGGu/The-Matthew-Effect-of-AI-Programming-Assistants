struct Solution;

impl Solution {
    pub fn is_valid_number(s: String) -> bool {
        let s = s.trim();
        if s.is_empty() {
            return false;
        }

        let mut has_digit = false;
        let mut has_exponent = false;
        let mut has_sign = false;
        let mut has_dot = false;

        for (i, c) in s.chars().enumerate() {
            match c {
                '0'..='9' => has_digit = true,
                '+' | '-' => {
                    if has_sign || i > 0 && !has_exponent {
                        return false;
                    }
                    has_sign = true;
                },
                'e' => {
                    if has_exponent || !has_digit {
                        return false;
                    }
                    has_exponent = true;
                    has_sign = false;
                    has_dot = false;
                    has_digit = false;
                },
                '.' => {
                    if has_dot || has_exponent {
                        return false;
                    }
                    has_dot = true;
                },
                _ => return false,
            }
        }

        has_digit
    }
}