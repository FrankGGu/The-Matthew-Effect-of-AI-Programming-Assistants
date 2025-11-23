impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn replace_words(mut dict: Vec<String>, s: String) -> String {
        dict.sort_by(|a, b| a.len().cmp(&b.len()));
        let mut root_map = HashMap::new();

        for word in &dict {
            root_map.insert(word, ());
        }

        let mut result = String::new();
        let mut i = 0;
        let chars: Vec<char> = s.chars().collect();

        while i < chars.len() {
            let mut j = i;
            let mut found = false;

            while j < chars.len() {
                let substr = &chars[i..j+1];
                let substr_str: String = substr.iter().collect();

                if root_map.contains_key(&substr_str) {
                    result.push_str(&substr_str);
                    i = j + 1;
                    found = true;
                    break;
                }

                j += 1;
            }

            if !found {
                result.push(chars[i]);
                i += 1;
            }
        }

        result
    }
}
}