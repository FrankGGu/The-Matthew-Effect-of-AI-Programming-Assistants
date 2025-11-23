impl Solution {
    pub fn decode_message(key: String, message: String) -> String {
        let mut mapping = std::collections::HashMap::new();
        let mut next_char = 'a';
        let mut result = String::new();

        for c in key.chars() {
            if c != ' ' && !mapping.contains_key(&c) {
                mapping.insert(c, next_char);
                next_char = ((next_char as u8) + 1) as char;
            }
        }

        for c in message.chars() {
            if c == ' ' {
                result.push(' ');
            } else {
                result.push(*mapping.get(&c).unwrap());
            }
        }

        result
    }
}