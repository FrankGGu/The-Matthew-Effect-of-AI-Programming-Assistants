impl Solution {
    pub fn strong_password_checker(password: String) -> i32 {
        let n = password.len();
        let has_upper = password.chars().any(|c| c.is_uppercase());
        let has_lower = password.chars().any(|c| c.is_lowercase());
        let has_digit = password.chars().any(|c| c.is_digit(10));

        let missing_types = !has_upper as i32 + !has_lower as i32 + !has_digit as i32;

        let mut replace = 0;
        let mut one = 0;
        let mut two = 0;
        let mut i = 2;

        let mut chars = password.chars().collect::<Vec<_>>();

        while i < n {
            if chars[i] == chars[i - 1] && chars[i] == chars[i - 2] {
                replace += 1;
                if i + 1 < n && chars[i] == chars[i + 1] {
                    if i + 2 < n && chars[i] == chars[i + 2] {
                        two += 1;
                        i += 2;
                    } else {
                        one += 1;
                        i += 1;
                    }
                } else {
                    i += 1;
                }
            } else {
                i += 1;
            }
        }

        if n < 6 {
            return (6 - n).max(missing_types);
        } else if n <= 20 {
            return replace.max(missing_types);
        } else {
            let excess = n - 20;
            replace -= excess / 3;
            replace = replace.max(0);
            let result = excess + missing_types + replace;
            return result as i32;
        }
    }
}