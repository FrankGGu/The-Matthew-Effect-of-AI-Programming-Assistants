impl Solution {
    pub fn my_atoi(s: String) -> i32 {
        let s = s.as_bytes();
        let mut i = 0;
        let n = s.len();

        while i < n && s[i] == b' ' {
            i += 1;
        }

        let mut sign = 1;
        if i < n {
            if s[i] == b'-' {
                sign = -1;
                i += 1;
            } else if s[i] == b'+' {
                i += 1;
            }
        }

        let mut result: i32 = 0;
        let max_div_10 = i32::MAX / 10;

        while i < n && s[i] >= b'0' && s[i] <= b'9' {
            let digit = (s[i] - b'0') as i32;

            if sign == 1 {
                if result > max_div_10 || (result == max_div_10 && digit > 7) {
                    return i32::MAX;
                }
            } else {
                if result > max_div_10 || (result == max_div_10 && digit > 8) {
                    return i32::MIN;
                }
            }

            result = result * 10 + digit;
            i += 1;
        }

        result * sign
    }
}