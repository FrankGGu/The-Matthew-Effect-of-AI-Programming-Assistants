impl Solution {
    pub fn my_atoi(s: String) -> i32 {
        let mut index = 0;
        let mut sign = 1;
        let mut total = 0;
        let n = s.len();

        while index < n && s.as_bytes()[index] == b' ' {
            index += 1;
        }

        if index < n && (s.as_bytes()[index] == b'-' || s.as_bytes()[index] == b'+') {
            if s.as_bytes()[index] == b'-' {
                sign = -1;
            }
            index += 1;
        }

        while index < n {
            let digit = s.as_bytes()[index] as i32 - b'0' as i32;
            if digit < 0 || digit > 9 {
                break;
            }
            if total > (i32::MAX / 10) || (total == i32::MAX / 10 && digit > 7) {
                return if sign == 1 { i32::MAX } else { i32::MIN };
            }
            total = total * 10 + digit;
            index += 1;
        }

        sign * total
    }
}