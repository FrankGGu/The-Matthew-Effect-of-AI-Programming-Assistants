impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn ladder_length(begin_word: String, end_word: String, word_list: Vec<String>) -> i32 {
        let word_set: HashSet<String> = word_list.into_iter().collect();
        if !word_set.contains(&end_word) {
            return 0;
        }

        let mut queue = VecDeque::new();
        queue.push_back((begin_word, 1));

        while let Some((current, steps)) = queue.pop_front() {
            for i in 0..current.len() {
                let mut next_word = current.clone();
                for c in 'a'..='z' {
                    next_word.replace_range(i..i + 1, &c.to_string());
                    if next_word == end_word {
                        return steps + 1;
                    }
                    if word_set.contains(&next_word) {
                        queue.push_back((next_word, steps + 1));
                        word_set.remove(&next_word);
                    }
                }
            }
        }

        0
    }
}
}