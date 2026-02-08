impl Solution {
    pub fn convert_to_base7(num: i32) -> String {
        if num == 0 {
            return "0".to_string();
        }

        let mut n = num.abs();
        let is_negative = num < 0;
        let mut result_chars = Vec::new();

        while n > 0 {
            result_chars.push(std::char::from_digit((n % 7) as u32, 10).unwrap());
            n /= 7;
        }

        let mut result_string: String = result_chars.into_iter().rev().collect();

        if is_negative {
            result_string.insert(0, '-');
        }

        result_string
    }
}