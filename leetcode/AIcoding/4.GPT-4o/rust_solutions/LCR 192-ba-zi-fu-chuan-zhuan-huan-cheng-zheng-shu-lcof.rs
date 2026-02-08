impl Solution {
    pub fn my_atoi(s: String) -> i32 {
        let s = s.trim();
        if s.is_empty() {
            return 0;
        }
        let mut sign = 1;
        let mut index = 0;
        if s.chars().nth(0) == Some('-') {
            sign = -1;
            index += 1;
        } else if s.chars().nth(0) == Some('+') {
            index += 1;
        }
        let mut result = 0;
        while index < s.len() {
            let digit = s.chars().nth(index).unwrap();
            if !digit.is_digit(10) {
                break;
            }
            let digit = digit.to_digit(10).unwrap() as i32;
            if result > (i32::MAX - digit) / 10 {
                return if sign == 1 { i32::MAX } else { i32::MIN };
            }
            result = result * 10 + digit;
            index += 1;
        }
        result * sign
    }
}