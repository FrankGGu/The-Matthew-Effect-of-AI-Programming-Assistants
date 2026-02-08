impl Solution {
    pub fn my_atoi(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mut i = 0;

        while i < n && s_bytes[i] == b' ' {
            i += 1;
        }

        let mut sign = 1;
        if i < n {
            if s_bytes[i] == b'-' {
                sign = -1;
                i += 1;
            } else if s_bytes[i] == b'+' {
                i += 1;
            }
        }

        let mut result: i32 = 0;
        let limit_pos_div10 = i32::MAX / 10;
        let limit_neg_div10 = i32::MIN / 10;

        while i < n && s_bytes[i].is_ascii_digit() {
            let digit = (s_bytes[i] - b'0') as i32;

            if sign == 1 {
                if result > limit_pos_div10 || (result == limit_pos_div10 && digit > 7) {
                    return i32::MAX;
                }
                result = result * 10 + digit;
            } else { // sign == -1
                if result < limit_neg_div10 || (result == limit_neg_div10 && digit > 8) {
                    return i32::MIN;
                }
                result = result * 10 - digit;
            }
            i += 1;
        }

        result
    }
}