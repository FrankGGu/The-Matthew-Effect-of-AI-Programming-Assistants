impl Solution {
    pub fn is_strong_password(password: String) -> bool {
        let n = password.len();
        if n < 8 {
            return false;
        }

        let mut has_lower = false;
        let mut has_upper = false;
        let mut has_digit = false;
        let mut has_special = false;

        let special_chars_str = "!@#$%^&*()-+";

        let chars: Vec<char> = password.chars().collect();

        for i in 0..n {
            let c = chars[i];

            if c.is_ascii_lowercase() {
                has_lower = true;
            } else if c.is_ascii_uppercase() {
                has_upper = true;
            } else if c.is_ascii_digit() {
                has_digit = true;
            } else if special_chars_str.contains(c) {
                has_special = true;
            }

            if i > 0 && chars[i] == chars[i - 1] {
                return false;
            }
        }

        has_lower && has_upper && has_digit && has_special
    }
}