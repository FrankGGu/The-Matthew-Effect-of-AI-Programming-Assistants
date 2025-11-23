use std::collections::HashMap;

impl Solution {
    pub fn evaluate(s: String, knowledge: Vec<Vec<String>>) -> String {
        let mut map: HashMap<String, String> = HashMap::new();
        for pair in knowledge {
            map.insert(pair[0].clone(), pair[1].clone());
        }
        let mut result = String::new();
        let mut chars = s.chars().peekable();
        while let Some(c) = chars.next() {
            if c == '(' {
                let mut key = String::new();
                while let Some(&next_c) = chars.peek() {
                    if next_c == ')' {
                        chars.next();
                        break;
                    } else {
                        key.push(chars.next().unwrap());
                    }
                }
                let value = map.get(&key).map_or("?".to_string(), |v| v.clone());
                result.push_str(&value);
            } else {
                result.push(c);
            }
        }
        result
    }
}