impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn decode_message(key: String, message: String) -> String {
        let mut map = HashMap::new();
        let mut index = 0;

        for c in key.chars() {
            if c != ' ' && !map.contains_key(&c) {
                map.insert(c, index);
                index += 1;
            }
        }

        let mut result = String::new();
        for c in message.chars() {
            if c == ' ' {
                result.push(' ');
            } else {
                let &val = map.get(&c).unwrap();
                result.push((b'a' + val) as char);
            }
        }

        result
    }
}
}