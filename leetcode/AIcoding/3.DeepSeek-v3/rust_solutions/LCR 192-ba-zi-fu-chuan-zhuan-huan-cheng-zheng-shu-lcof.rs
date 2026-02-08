impl Solution {
    pub fn my_atoi(s: String) -> i32 {
        let s = s.trim();
        if s.is_empty() {
            return 0;
        }

        let mut chars = s.chars().peekable();
        let mut sign = 1;
        let mut result: i64 = 0;

        match chars.peek() {
            Some('+') => {
                chars.next();
            }
            Some('-') => {
                sign = -1;
                chars.next();
            }
            _ => {}
        }

        while let Some(&c) = chars.peek() {
            if !c.is_ascii_digit() {
                break;
            }
            let digit = c.to_digit(10).unwrap() as i64;
            result = result * 10 + digit;
            if result * sign > i32::MAX as i64 {
                return i32::MAX;
            }
            if result * sign < i32::MIN as i64 {
                return i32::MIN;
            }
            chars.next();
        }

        (result * sign) as i32
    }
}