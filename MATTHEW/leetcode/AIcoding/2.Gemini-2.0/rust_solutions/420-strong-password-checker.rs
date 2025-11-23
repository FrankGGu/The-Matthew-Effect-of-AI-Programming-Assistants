impl Solution {
    pub fn strong_password_checker(password: String) -> i32 {
        let n = password.len();
        let s: Vec<char> = password.chars().collect();

        let mut missing_types = 0;
        if !s.iter().any(|&c| c.is_digit(10)) {
            missing_types += 1;
        }
        if !s.iter().any(|&c| c.is_lowercase()) {
            missing_types += 1;
        }
        if !s.iter().any(|&c| c.is_uppercase()) {
            missing_types += 1;
        }

        if n < 6 {
            return std::cmp::max(missing_types, 6 - n as i32);
        }

        let mut changes = 0;
        let mut one = 0;
        let mut two = 0;

        let mut i = 0;
        while i < n {
            let mut j = i;
            while j < n && s[i] == s[j] {
                j += 1;
            }
            let len = j - i;
            if len >= 3 {
                changes += len / 3;
                if len % 3 == 0 {
                    one += 1;
                } else if len % 3 == 1 {
                    two += 1;
                }
            }
            i = j;
        }

        if n > 20 {
            let delete = n as i32 - 20;
            changes -= std::cmp::min(delete, one);
            changes -= std::cmp::min(std::cmp::max(delete - one, 0) / 2, two);
            changes -= std::cmp::max(delete - one - 2 * two, 0) / 3;
            return delete + std::cmp::max(missing_types, changes);
        } else {
            return std::cmp::max(missing_types, changes);
        }
    }
}