impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_longest_word(mut s: String, mut dictionary: Vec<String>) -> String {
        dictionary.sort_unstable();
        let mut map = HashMap::new();
        for word in &dictionary {
            map.entry(word.len()).or_insert_with(Vec::new).push(word);
        }
        let mut result = String::new();
        for len in (1..=s.len()).rev() {
            if let Some(words) = map.get(&len) {
                for word in words {
                    let mut i = 0;
                    for c in s.chars() {
                        if i < word.len() && c == word.chars().nth(i).unwrap() {
                            i += 1;
                        }
                    }
                    if i == word.len() {
                        if word.len() > result.len() || (word.len() == result.len() && word < &result) {
                            result = word.clone();
                        }
                    }
                }
            }
        }
        result
    }
}
}