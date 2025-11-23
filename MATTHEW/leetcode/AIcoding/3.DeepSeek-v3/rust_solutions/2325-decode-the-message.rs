use std::collections::HashMap;

impl Solution {
    pub fn decode_message(key: String, message: String) -> String {
        let mut substitution = HashMap::new();
        let mut current_char = b'a';
        for c in key.chars() {
            if c != ' ' && !substitution.contains_key(&c) {
                substitution.insert(c, current_char as char);
                current_char += 1;
                if current_char > b'z' {
                    break;
                }
            }
        }
        let mut decoded = String::new();
        for c in message.chars() {
            if c == ' ' {
                decoded.push(' ');
            } else {
                decoded.push(*substitution.get(&c).unwrap());
            }
        }
        decoded
    }
}