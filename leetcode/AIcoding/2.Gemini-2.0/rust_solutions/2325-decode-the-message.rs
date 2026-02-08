impl Solution {
    pub fn decode_message(key: String, message: String) -> String {
        let mut map = std::collections::HashMap::new();
        let mut current_char = 'a';
        for c in key.chars() {
            if c != ' ' && !map.contains_key(&c) {
                map.insert(c, current_char);
                current_char = (current_char as u8 + 1) as char;
            }
        }

        let mut result = String::new();
        for c in message.chars() {
            if c == ' ' {
                result.push(' ');
            } else {
                result.push(*map.get(&c).unwrap());
            }
        }

        result
    }
}