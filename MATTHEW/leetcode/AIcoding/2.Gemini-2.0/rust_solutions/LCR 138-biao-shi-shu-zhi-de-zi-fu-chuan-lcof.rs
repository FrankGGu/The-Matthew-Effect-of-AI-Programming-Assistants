impl Solution {
    pub fn is_number(s: String) -> bool {
        let s = s.trim();
        let mut has_digit = false;
        let mut has_e = false;
        let mut has_dot = false;
        let bytes = s.as_bytes();
        for i in 0..bytes.len() {
            let c = bytes[i];
            match c {
                b'0'..=b'9' => {
                    has_digit = true;
                }
                b'.' => {
                    if has_e || has_dot {
                        return false;
                    }
                    has_dot = true;
                }
                b'e' | b'E' => {
                    if has_e || !has_digit {
                        return false;
                    }
                    has_e = true;
                    has_digit = false;
                }
                b'+' | b'-' => {
                    if i != 0 && bytes[i - 1] != b'e' && bytes[i - 1] != b'E' {
                        return false;
                    }
                }
                _ => {
                    return false;
                }
            }
        }
        has_digit
    }
}