use std::collections::HashMap;

impl Solution {
    pub fn longest_palindrome(words: Vec<String>) -> i32 {
        let mut freq = HashMap::new();
        for word in words {
            *freq.entry(word).or_insert(0) += 1;
        }

        let mut length = 0;
        let mut has_central = false;

        for (word, count) in &freq {
            let chars: Vec<char> = word.chars().collect();
            if chars[0] == chars[1] {
                if *count % 2 == 1 {
                    has_central = true;
                }
                length += (*count / 2) * 2;
            } else {
                let reversed = format!("{}{}", chars[1], chars[0]);
                if let Some(&reversed_count) = freq.get(&reversed) {
                    length += std::cmp::min(*count, reversed_count);
                }
            }
        }

        if has_central {
            length += 1;
        }

        length * 2
    }
}