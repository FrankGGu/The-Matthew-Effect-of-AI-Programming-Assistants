use std::collections::HashSet;

impl Solution {
    pub fn word_transformable(begin_word: String, end_word: String, word_list: Vec<String>) -> bool {
        let word_set: HashSet<String> = word_list.into_iter().collect();
        if !word_set.contains(&end_word) {
            return false;
        }

        let mut queue = vec![begin_word.clone()];
        let mut visited = HashSet::new();
        visited.insert(begin_word);

        while let Some(current) = queue.pop() {
            if current == end_word {
                return true;
            }
            let current_chars: Vec<char> = current.chars().collect();
            for i in 0..current.len() {
                let original_char = current_chars[i];
                for c in 'a'..='z' {
                    if c == original_char {
                        continue;
                    }
                    let mut new_word_chars = current_chars.clone();
                    new_word_chars[i] = c;
                    let new_word: String = new_word_chars.iter().collect();
                    if word_set.contains(&new_word) && !visited.contains(&new_word) {
                        visited.insert(new_word.clone());
                        queue.push(new_word);
                    }
                }
            }
        }
        false
    }
}