impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn common_chars(mut words: Vec<String>) -> Vec<char> {
        let mut common_map = HashMap::new();
        let first_word = &words[0];

        for c in first_word.chars() {
            *common_map.entry(c).or_insert(0) += 1;
        }

        for word in words.iter().skip(1) {
            let mut current_map = HashMap::new();
            for c in word.chars() {
                *current_map.entry(c).or_insert(0) += 1;
            }

            let mut to_remove = Vec::new();
            for (c, count) in &common_map {
                if let Some(&current_count) = current_map.get(c) {
                    if current_count < *count {
                        *common_map.get_mut(c).unwrap() = current_count;
                    }
                } else {
                    to_remove.push(*c);
                }
            }

            for c in to_remove {
                common_map.remove(&c);
            }
        }

        let mut result = Vec::new();
        for (c, count) in common_map {
            for _ in 0..count {
                result.push(c);
            }
        }

        result
    }
}
}