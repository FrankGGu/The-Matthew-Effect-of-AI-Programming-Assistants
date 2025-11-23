use std::collections::HashMap;

impl Solution {
    pub fn evaluate(s: String, knowledge: Vec<Vec<String>>) -> String {
        let mut map: HashMap<String, String> = HashMap::new();
        for pair in knowledge {
            map.insert(pair[0].clone(), pair[1].clone());
        }

        let mut result = String::new();
        let mut in_bracket = false;
        let mut current_key = String::new();

        for c in s.chars() {
            if c == '(' {
                in_bracket = true;
                current_key.clear();
            } else if c == ')' {
                in_bracket = false;
                let value = map.get(&current_key).map_or("?", |v| v.as_str());
                result.push_str(value);
            } else {
                if in_bracket {
                    current_key.push(c);
                } else {
                    result.push(c);
                }
            }
        }

        result
    }
}