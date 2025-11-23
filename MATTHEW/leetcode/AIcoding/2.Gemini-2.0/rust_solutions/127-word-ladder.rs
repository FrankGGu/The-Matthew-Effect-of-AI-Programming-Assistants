use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn ladder_length(begin_word: String, end_word: String, word_list: Vec<String>) -> i32 {
        if !word_list.contains(&end_word) {
            return 0;
        }

        let mut word_set: HashSet<String> = word_list.into_iter().collect();
        let mut queue: VecDeque<(String, i32)> = VecDeque::new();
        queue.push_back((begin_word, 1));
        let mut visited: HashSet<String> = HashSet::new();
        visited.insert(begin_word.clone());

        while let Some((current_word, level)) = queue.pop_front() {
            if current_word == end_word {
                return level;
            }

            for i in 0..current_word.len() {
                let mut chars: Vec<char> = current_word.chars().collect();
                for c in 'a'..='z' {
                    let original_char = chars[i];
                    chars[i] = c;
                    let new_word: String = chars.iter().collect();

                    if word_set.contains(&new_word) && !visited.contains(&new_word) {
                        queue.push_back((new_word.clone(), level + 1));
                        visited.insert(new_word.clone());
                    }
                    chars[i] = original_char;
                }
            }
        }

        0
    }
}