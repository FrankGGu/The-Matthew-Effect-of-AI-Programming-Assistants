impl Solution {
    pub fn strong_password_checker_ii(password: String) -> bool {
        if password.len() < 8 {
            return false;
        }

        let mut has_lower = false;
        let mut has_upper = false;
        let mut has_digit = false;
        let mut has_special = false;
        let special_chars = "!@#$%^&*()-+";
        let mut prev_char = '\0';

        for c in password.chars() {
            if c == prev_char {
                return false;
            }
            prev_char = c;

            if c.is_ascii_lowercase() {
                has_lower = true;
            } else if c.is_ascii_uppercase() {
                has_upper = true;
            } else if c.is_ascii_digit() {
                has_digit = true;
            } else if special_chars.contains(c) {
                has_special = true;
            }
        }

        has_lower && has_upper && has_digit && has_special
    }
}