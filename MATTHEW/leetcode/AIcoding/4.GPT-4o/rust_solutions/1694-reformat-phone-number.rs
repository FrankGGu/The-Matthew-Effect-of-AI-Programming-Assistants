impl Solution {
    pub fn reformat_number(number: String) -> String {
        let digits: Vec<char> = number.chars().filter(|c| c.is_digit(10)).collect();
        let mut result = String::new();
        let len = digits.len();
        let mut i = 0;

        while i < len {
            if len - i > 4 {
                result.push(digits[i]);
                result.push(digits[i + 1]);
                result.push('-');
                i += 2;
            } else if len - i == 4 {
                result.push(digits[i]);
                result.push(digits[i + 1]);
                result.push('-');
                result.push(digits[i + 2]);
                result.push(digits[i + 3]);
                break;
            } else {
                result.push_str(&digits[i..].iter().collect::<String>());
                break;
            }
        }

        result.trim_end_matches('-').to_string()
    }
}