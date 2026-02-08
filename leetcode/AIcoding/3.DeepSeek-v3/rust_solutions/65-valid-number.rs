impl Solution {
    pub fn is_number(s: String) -> bool {
        let s = s.trim();
        let mut seen_digit = false;
        let mut seen_dot = false;
        let mut seen_e = false;

        for (i, c) in s.chars().enumerate() {
            match c {
                '0'..='9' => {
                    seen_digit = true;
                },
                '+' | '-' => {
                    if i > 0 && s.chars().nth(i - 1) != Some('e') && s.chars().nth(i - 1) != Some('E') {
                        return false;
                    }
                },
                '.' => {
                    if seen_dot || seen_e {
                        return false;
                    }
                    seen_dot = true;
                },
                'e' | 'E' => {
                    if seen_e || !seen_digit {
                        return false;
                    }
                    seen_e = true;
                    seen_digit = false;
                },
                _ => return false,
            }
        }

        seen_digit
    }
}