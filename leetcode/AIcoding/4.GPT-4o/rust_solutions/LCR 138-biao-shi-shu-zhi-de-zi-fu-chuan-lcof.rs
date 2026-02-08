impl Solution {
    pub fn is_number(s: String) -> bool {
        let s = s.trim();
        let mut seen_digit = false;
        let mut seen_dot = false;
        let mut seen_e = false;
        let mut i = 0;

        if s.is_empty() {
            return false;
        }

        if s.chars().nth(0) == Some('-') || s.chars().nth(0) == Some('+') {
            i += 1;
        }

        while i < s.len() {
            match s.chars().nth(i) {
                Some(c) if c.is_digit(10) => {
                    seen_digit = true;
                }
                Some('.') if !seen_dot && !seen_e => {
                    seen_dot = true;
                }
                Some('e') | Some('E') if seen_digit && !seen_e => {
                    seen_e = true;
                    if i + 1 < s.len() && (s.chars().nth(i + 1) == Some('-') || s.chars().nth(i + 1) == Some('+')) {
                        i += 1;
                    }
                }
                Some(c) if c == '-' || c == '+' => {
                    if s.chars().nth(i.wrapping_sub(1)) != Some('e') && s.chars().nth(i.wrapping_sub(1)) != Some('E') {
                        return false;
                    }
                }
                _ => return false,
            }
            i += 1;
        }

        seen_digit
    }
}