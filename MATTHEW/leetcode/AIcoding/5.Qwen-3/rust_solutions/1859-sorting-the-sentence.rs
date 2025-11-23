impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sort_sentence(s: String) -> String {
        let words: Vec<&str> = s.split_whitespace().collect();
        let mut map: HashMap<usize, &str> = HashMap::new();

        for word in words {
            let idx = word.chars().rev().next().unwrap().to_digit(10).unwrap() as usize;
            map.insert(idx, word);
        }

        let mut result = String::new();
        for i in 1..=words.len() {
            if let Some(word) = map.get(&i) {
                result.push_str(word);
                if i != words.len() {
                    result.push(' ');
                }
            }
        }

        result
    }
}
}