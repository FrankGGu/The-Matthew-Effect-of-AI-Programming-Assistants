impl Solution {
    pub fn largest_good_integer(num: String) -> String {
        let mut max_digit = -1;
        let bytes = num.as_bytes();
        for i in 0..bytes.len().saturating_sub(2) {
            if bytes[i] == bytes[i + 1] && bytes[i] == bytes[i + 2] {
                let current_digit = (bytes[i] - b'0') as i32;
                if current_digit > max_digit {
                    max_digit = current_digit;
                }
            }
        }
        if max_digit == -1 {
            String::new()
        } else {
            format!("{}{}{}", max_digit, max_digit, max_digit)
        }
    }
}