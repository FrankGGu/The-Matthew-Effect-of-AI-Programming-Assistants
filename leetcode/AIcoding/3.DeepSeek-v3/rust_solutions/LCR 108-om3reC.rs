use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn ladder_length(begin_word: String, end_word: String, word_list: Vec<String>) -> i32 {
        let word_set: HashSet<_> = word_list.into_iter().collect();
        if !word_set.contains(&end_word) {
            return 0;
        }
        let mut queue = VecDeque::new();
        queue.push_back((begin_word.clone(), 1));
        let mut visited = HashSet::new();
        visited.insert(begin_word);

        while let Some((current_word, steps)) = queue.pop_front() {
            if current_word == end_word {
                return steps;
            }
            for i in 0..current_word.len() {
                let mut chars: Vec<char> = current_word.chars().collect();
                for c in 'a'..='z' {
                    chars[i] = c;
                    let new_word: String = chars.iter().collect();
                    if word_set.contains(&new_word) && !visited.contains(&new_word) {
                        visited.insert(new_word.clone());
                        queue.push_back((new_word, steps + 1));
                    }
                }
            }
        }
        0
    }
}