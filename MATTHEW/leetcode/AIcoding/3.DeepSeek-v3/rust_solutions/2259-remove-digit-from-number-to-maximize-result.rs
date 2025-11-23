impl Solution {
    pub fn remove_digit(number: String, digit: char) -> String {
        let mut max_num = String::new();
        let bytes = number.as_bytes();
        for i in 0..bytes.len() {
            if bytes[i] == digit as u8 {
                let current = format!(
                    "{}{}",
                    &number[..i],
                    &number[i + 1..]
                );
                if current > max_num {
                    max_num = current;
                }
            }
        }
        max_num
    }
}