impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn string_transformations(s: String, mappings: Vec<Vec<char>>) -> i32 {
        let mut map = HashMap::new();
        for pair in mappings {
            map.insert(pair[0], pair[1]);
        }

        let mut result = 0;
        for c in s.chars() {
            if let Some(&target) = map.get(&c) {
                result += target as i32;
            } else {
                result += c as i32;
            }
        }
        result
    }
}
}