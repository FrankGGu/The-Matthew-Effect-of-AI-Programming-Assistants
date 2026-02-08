impl Solution {
    pub fn replace_digits(s: String) -> String {
        let mut result = String::new();
        let bytes = s.as_bytes();

        for i in 0..s.len() {
            if i % 2 == 0 {
                result.push(bytes[i] as char);
            } else {
                let offset = (bytes[i] - b'0') as usize;
                let new_char = (bytes[i - 1] as usize + offset) as u8 as char;
                result.push(new_char);
            }
        }

        result
    }
}