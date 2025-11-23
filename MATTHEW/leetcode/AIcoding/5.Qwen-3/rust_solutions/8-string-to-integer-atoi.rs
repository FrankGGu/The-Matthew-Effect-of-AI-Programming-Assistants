struct Solution;

impl Solution {
    pub fn my_atoi(s: String) -> i32 {
        let s = s.trim_start();
        if s.is_empty() {
            return 0;
        }

        let mut sign = 1;
        let mut i = 0;

        if s.chars().nth(0) == Some('-') {
            sign = -1;
            i += 1;
        } else if s.chars().nth(0) == Some('+') {
            i += 1;
        }

        let mut num = 0;

        while i < s.len() {
            let c = s.chars().nth(i).unwrap();
            if !c.is_digit(10) {
                break;
            }

            let digit = c.to_digit(10).unwrap() as i32;
            num = num.saturating_mul(10).saturating_add(digit);

            if num > i32::MAX {
                return i32::MAX;
            } else if num < i32::MIN {
                return i32::MIN;
            }

            i += 1;
        }

        num * sign
    }
}