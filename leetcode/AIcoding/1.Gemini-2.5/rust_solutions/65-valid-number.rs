impl Solution {
    pub fn is_number(s: String) -> bool {
        let s = s.trim();
        if s.is_empty() {
            return false;
        }

        let mut seen_digit = false;
        let mut seen_dot = false;
        let mut seen_e = false;

        let chars: Vec<char> = s.chars().collect();

        for (i, &c) in chars.iter().enumerate() {
            match c {
                '0'..='9' => {
                    seen_digit = true;
                }
                '.' => {
                    if seen_dot || seen_e {
                        return false;
                    }
                    seen_dot = true;
                }
                'e' | 'E' => {
                    if seen_e || !seen_digit {
                        return false;
                    }
                    seen_e = true;
                    seen_digit = false; 
                }
                '+' | '-' => {
                    if i != 0 && chars[i - 1] != 'e' && chars[i - 1] != 'E' {
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