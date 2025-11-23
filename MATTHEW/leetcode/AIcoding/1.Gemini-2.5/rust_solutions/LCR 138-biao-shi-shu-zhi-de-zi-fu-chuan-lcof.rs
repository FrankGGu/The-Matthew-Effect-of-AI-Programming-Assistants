impl Solution {
    pub fn is_number(s: String) -> bool {
        let s = s.trim();
        if s.is_empty() {
            return false;
        }

        let mut has_digit = false;
        let mut has_dot = false;
        let mut has_e = false;
        let mut sign_allowed_at_current_pos = true;

        for c in s.chars() {
            match c {
                '0'..='9' => {
                    has_digit = true;
                    sign_allowed_at_current_pos = false;
                }
                '+' | '-' => {
                    if !sign_allowed_at_current_pos {
                        return false;
                    }
                    sign_allowed_at_current_pos = false;
                }
                '.' => {
                    if has_dot || has_e {
                        return false;
                    }
                    has_dot = true;
                    sign_allowed_at_current_pos = false;
                }
                'e' | 'E' => {
                    if has_e || !has_digit {
                        return false;
                    }
                    has_e = true;
                    has_digit = false;
                    sign_allowed_at_current_pos = true;
                }
                _ => {
                    return false;
                }
            }
        }

        has_digit
    }
}