use std::collections::HashMap;

impl Solution {
    pub fn evaluate(s: String, knowledge: Vec<Vec<String>>) -> String {
        let mut map: HashMap<String, String> = HashMap::new();
        for pair in knowledge {
            map.insert(pair[0].clone(), pair[1].clone());
        }

        let mut result = String::new();
        let mut i = 0;
        while i < s.len() {
            if s.as_bytes()[i] == b'(' {
                let mut j = i + 1;
                while j < s.len() && s.as_bytes()[j] != b')' {
                    j += 1;
                }
                let key = &s[i + 1..j];
                if let Some(value) = map.get(key) {
                    result.push_str(value);
                } else {
                    result.push_str("?");
                }
                i = j + 1;
            } else {
                result.push(s.as_bytes()[i] as char);
                i += 1;
            }
        }

        result
    }
}