pub fn strong_password_checker_ii(password: String) -> bool {
    let n = password.len();
    if n < 8 {
        return false;
    }

    let mut has_lower = false;
    let mut has_upper = false;
    let mut has_digit = false;
    let mut has_special = false;
    let special_chars = "!@#$%^&*()-+";

    for (i, c) in password.chars().enumerate() {
        if c.is_lowercase() {
            has_lower = true;
        } else if c.is_uppercase() {
            has_upper = true;
        } else if c.is_digit(10) {
            has_digit = true;
        } else if special_chars.contains(c) {
            has_special = true;
        }
        if i > 0 && password.chars().nth(i) == password.chars().nth(i - 1) {
            return false;
        }
    }

    has_lower && has_upper && has_digit && has_special
}