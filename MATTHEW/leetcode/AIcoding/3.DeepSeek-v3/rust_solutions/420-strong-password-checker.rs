impl Solution {
    pub fn strong_password_checker(password: String) -> i32 {
        let n = password.len();
        let (mut has_lower, mut has_upper, mut has_digit) = (false, false, false);
        for ch in password.chars() {
            if ch.is_ascii_lowercase() {
                has_lower = true;
            } else if ch.is_ascii_uppercase() {
                has_upper = true;
            } else if ch.is_ascii_digit() {
                has_digit = true;
            }
        }
        let missing_types = (!has_lower as i32) + (!has_upper as i32) + (!has_digit as i32);

        let mut replace = 0;
        let mut one_seq = 0;
        let mut two_seq = 0;
        let mut i = 2;
        while i < n {
            if password.as_bytes()[i] == password.as_bytes()[i - 1] && password.as_bytes()[i - 1] == password.as_bytes()[i - 2] {
                let mut length = 2;
                while i < n && password.as_bytes()[i] == password.as_bytes()[i - 1] {
                    length += 1;
                    i += 1;
                }
                replace += length / 3;
                if length % 3 == 0 {
                    one_seq += 1;
                } else if length % 3 == 1 {
                    two_seq += 1;
                }
            } else {
                i += 1;
            }
        }

        if n < 6 {
            std::cmp::max(missing_types, (6 - n) as i32)
        } else if n <= 20 {
            std::cmp::max(missing_types, replace)
        } else {
            let delete = n - 20;
            replace -= std::cmp::min(delete, one_seq * 1) / 1;
            replace -= std::cmp::min(std::cmp::max(delete - one_seq, 0), two_seq * 2) / 2;
            replace -= std::cmp::max(delete - one_seq - 2 * two_seq, 0) / 3;
            delete as i32 + std::cmp::max(missing_types, replace)
        }
    }
}