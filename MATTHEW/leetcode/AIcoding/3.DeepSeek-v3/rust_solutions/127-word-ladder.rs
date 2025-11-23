use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn ladder_length(begin_word: String, end_word: String, word_list: Vec<String>) -> i32 {
        let mut word_set: HashSet<String> = word_list.into_iter().collect();
        if !word_set.contains(&end_word) {
            return 0;
        }

        let mut queue = VecDeque::new();
        queue.push_back((begin_word.clone(), 1));
        word_set.remove(&begin_word);

        while let Some((current_word, steps)) = queue.pop_front() {
            if current_word == end_word {
                return steps;
            }

            let mut chars: Vec<char> = current_word.chars().collect();
            for i in 0..chars.len() {
                let original_char = chars[i];
                for c in 'a'..='z' {
                    if c == original_char {
                        continue;
                    }
                    chars[i] = c;
                    let new_word: String = chars.iter().collect();
                    if word_set.contains(&new_word) {
                        queue.push_back((new_word.clone(), steps + 1));
                        word_set.remove(&new_word);
                    }
                }
                chars[i] = original_char;
            }
        }

        0
    }
}