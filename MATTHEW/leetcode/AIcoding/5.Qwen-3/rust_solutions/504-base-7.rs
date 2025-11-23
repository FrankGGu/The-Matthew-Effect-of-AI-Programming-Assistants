struct Solution;

impl Solution {
    pub fn convert_to_base_k(mut num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }
        let mut result = String::new();
        let is_negative = num < 0;
        if is_negative {
            num = -num;
        }
        while num > 0 {
            result.insert(0, (b'0' + (num % 7) as u8) as char);
            num /= 7;
        }
        if is_negative {
            result.insert(0, '-');
        }
        result
    }
}