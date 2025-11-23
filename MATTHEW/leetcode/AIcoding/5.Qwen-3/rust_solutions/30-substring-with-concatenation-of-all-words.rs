impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_substring(s: String, words: Vec<String>) -> Vec<i32> {
        if words.is_empty() || s.is_empty() {
            return vec![];
        }

        let word_len = words[0].len();
        let num_words = words.len();
        let total_len = word_len * num_words;
        let s_len = s.len();

        if total_len > s_len {
            return vec![];
        }

        let mut word_count = HashMap::new();
        for word in &words {
            *word_count.entry(word).or_insert(0) += 1;
        }

        let mut result = Vec::new();

        for i in 0..word_len {
            let mut left = i;
            let mut right = i;
            let mut current_count = HashMap::new();
            let mut words_found = 0;

            while right + word_len <= s_len {
                let word = &s[right..right + word_len];
                right += word_len;

                if !word_count.contains_key(word) {
                    current_count.clear();
                    words_found = 0;
                    left = right;
                    continue;
                }

                *current_count.entry(word).or_insert(0) += 1;

                if current_count[word] > word_count[word] {
                    let mut removed = false;
                    while current_count[word] > word_count[word] {
                        let left_word = &s[left..left + word_len];
                        current_count.entry(left_word).and_modify(|e| *e -= 1);
                        if current_count[left_word] == 0 {
                            current_count.remove(left_word);
                        }
                        left += word_len;
                        removed = true;
                    }
                    if removed {
                        words_found -= 1;
                    }
                } else {
                    words_found += 1;
                }

                if words_found == num_words {
                    result.push(left as i32);
                    let left_word = &s[left..left + word_len];
                    current_count.entry(left_word).and_modify(|e| *e -= 1);
                    if current_count[left_word] == 0 {
                        current_count.remove(left_word);
                    }
                    left += word_len;
                    words_found -= 1;
                }
            }
        }

        result
    }
}
}