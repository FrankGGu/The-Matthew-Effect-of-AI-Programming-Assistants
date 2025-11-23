impl Solution {
    pub fn my_atoi(s: String) -> i32 {
        let s = s.trim_start();
        let mut sign = 1;
        let mut result: i64 = 0;
        let mut chars = s.chars();

        match chars.next() {
            Some('+') => {},
            Some('-') => sign = -1,
            Some(c) if c.is_digit(10) => {
                result = c.to_digit(10).unwrap() as i64;
            },
            _ => return 0,
        }

        for c in chars {
            if !c.is_digit(10) {
                break;
            }
            let digit = c.to_digit(10).unwrap() as i64;
            if result > (i32::MAX as i64) / 10 || (result == (i32::MAX as i64) / 10 && digit > 7) {
                if sign == 1 {
                    return i32::MAX;
                } else {
                    return i32::MIN;
                }
            }
            result = result * 10 + digit;
        }

        (sign as i64 * result) as i32
    }
}