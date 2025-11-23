impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn strong_password_checker_ii(password: String) -> bool {
        if password.len() < 6 {
            return false;
        }

        let mut has_lower = false;
        let mut has_upper = false;
        let mut has_digit = false;
        let mut has_special = false;
        let special_chars: HashSet<char> = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '+'].iter().cloned().collect();

        for (i, c) in password.chars().enumerate() {
            if c.is_lowercase() {
                has_lower = true;
            } else if c.is_uppercase() {
                has_upper = true;
            } else if c.is_ascii_digit() {
                has_digit = true;
            } else if special_chars.contains(&c) {
                has_special = true;
            }

            if i > 0 && c == password.chars().nth(i - 1).unwrap() {
                return false;
            }
        }

        has_lower && has_upper && has_digit && has_special
    }
}
}