use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn ladder_length(begin_word: String, end_word: String, word_list: Vec<String>) -> i32 {
        let word_set: HashSet<String> = word_list.into_iter().collect();
        if !word_set.contains(&end_word) {
            return 0;
        }

        let mut queue: VecDeque<(String, i32)> = VecDeque::new();
        queue.push_back((begin_word, 1));
        let mut visited: HashSet<String> = HashSet::new();
        visited.insert(begin_word.clone());

        while !queue.is_empty() {
            let (current_word, current_length) = queue.pop_front().unwrap();

            if current_word == end_word {
                return current_length;
            }

            for i in 0..current_word.len() {
                let mut chars: Vec<char> = current_word.chars().collect();
                for ch in b'a'..=b'z' {
                    chars[i] = ch as char;
                    let next_word: String = chars.iter().collect();

                    if word_set.contains(&next_word) && !visited.contains(&next_word) {
                        queue.push_back((next_word.clone(), current_length + 1));
                        visited.insert(next_word);
                    }
                }
            }
        }

        0
    }
}