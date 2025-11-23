use std::collections::{HashSet, VecDeque};

pub fn ladder_length(begin_word: String, end_word: String, word_list: Vec<String>) -> i32 {
    let word_set: HashSet<String> = word_list.into_iter().collect();
    if !word_set.contains(&end_word) {
        return 0;
    }

    let mut queue = VecDeque::new();
    queue.push_back((begin_word.clone(), 1));

    while let Some((current_word, length)) = queue.pop_front() {
        if current_word == end_word {
            return length;
        }

        let current_chars: Vec<char> = current_word.chars().collect();
        for i in 0..current_chars.len() {
            let original_char = current_chars[i];
            for c in b'a'..=b'z' {
                let mut new_word_chars = current_chars.clone();
                new_word_chars[i] = original_char.to_ascii_lowercase();
                let new_word: String = new_word_chars.iter().collect();

                if word_set.contains(&new_word) {
                    queue.push_back((new_word.clone(), length + 1));
                    word_set.remove(&new_word);
                }
            }
        }
    }

    0
}