use std::collections::{VecDeque, HashSet};

struct Solution;

impl Solution {
    pub fn ladder_length(begin_word: String, end_word: String, word_list: Vec<String>) -> i32 {
        let mut word_set: HashSet<String> = word_list.into_iter().collect();

        if !word_set.contains(&end_word) {
            return 0;
        }

        let mut queue: VecDeque<(String, i32)> = VecDeque::new();
        queue.push_back((begin_word.clone(), 1));

        // If begin_word is in the word_set, remove it to avoid cycles or redundant processing
        // as it's the starting point and already "visited" in the context of the queue.
        word_set.remove(&begin_word);

        while let Some((current_word, current_length)) = queue.pop_front() {
            if current_word == end_word {
                return current_length;
            }

            let mut chars: Vec<char> = current_word.chars().collect();

            for i in 0..chars.len() {
                let original_char = chars[i];
                for c in b'a'..=b'z' {
                    let new_char = c as char;
                    if new_char == original_char {
                        continue;
                    }
                    chars[i] = new_char;
                    let next_word: String = chars.iter().collect();

                    if word_set.contains(&next_word) {
                        word_set.remove(&next_word); // Mark as visited by removing from the set
                        queue.push_back((next_word, current_length + 1));
                    }
                }
                chars[i] = original_char; // Backtrack to restore the original character
            }
        }

        0
    }
}