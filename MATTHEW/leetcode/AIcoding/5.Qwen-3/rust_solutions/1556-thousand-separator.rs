struct Solution;

impl Solution {
    pub fn digits_to_string(mut num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }
        let mut result = String::new();
        let mut count = 0;
        while num > 0 {
            let digit = num % 10;
            result.push((b'0' + digit as u8) as char);
            num /= 10;
            count += 1;
            if count % 3 == 0 && num > 0 {
                result.push('.');
            }
        }
        result.chars().rev().collect()
    }
}