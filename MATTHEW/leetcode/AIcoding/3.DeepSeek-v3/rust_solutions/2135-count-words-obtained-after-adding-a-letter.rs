use std::collections::HashSet;

impl Solution {
    pub fn word_count(start_words: Vec<String>, target_words: Vec<String>) -> i32 {
        let mut seen = HashSet::new();
        for word in start_words {
            let mut chars: Vec<char> = word.chars().collect();
            chars.sort_unstable();
            seen.insert(chars);
        }

        let mut res = 0;
        for word in target_words {
            let mut chars: Vec<char> = word.chars().collect();
            chars.sort_unstable();
            for i in 0..chars.len() {
                let mut new_chars = chars.clone();
                new_chars.remove(i);
                if seen.contains(&new_chars) {
                    res += 1;
                    break;
                }
            }
        }
        res
    }
}