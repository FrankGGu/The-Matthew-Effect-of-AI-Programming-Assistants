use std::collections::HashMap;

impl Solution {
    pub fn find_substring(s: String, words: Vec<String>) -> Vec<i32> {
        let mut result = Vec::new();

        if words.is_empty() || s.is_empty() {
            return result;
        }

        let word_len = words[0].len();
        let num_words = words.len();
        let total_len = word_len * num_words;

        if total_len == 0 || total_len > s.len() {
            return result;
        }

        let mut target_counts: HashMap<&str, i32> = HashMap::new();
        for word in &words {
            *target_counts.entry(word.as_str()).or_insert(0) += 1;
        }

        let s_bytes = s.as_bytes();

        for i in 0..word_len {
            let mut current_counts: HashMap<&str, i32> = HashMap::new();
            let mut words_in_window = 0;
            let mut left = i;

            for right in (i..=(s.len() - word_len)).step_by(word_len) {
                let sub_word_slice = &s_bytes[right..right + word_len];
                let sub_word = unsafe { std::str::from_utf8_unchecked(sub_word_slice) };

                if let Some(&target_count) = target_counts.get(sub_word) {
                    *current_counts.entry(sub_word).or_insert(0) += 1;
                    words_in_window += 1;

                    while *current_counts.get(sub_word).unwrap() > target_count {
                        let left_word_slice = &s_bytes[left..left + word_len];
                        let left_word = unsafe { std::str::from_utf8_unchecked(left_word_slice) };

                        *current_counts.get_mut(left_word).unwrap() -= 1;
                        words_in_window -= 1;
                        left += word_len;
                    }

                    if words_in_window == num_words {
                        result.push(left as i32);

                        let left_word_slice = &s_bytes[left..left + word_len];
                        let left_word = unsafe { std::str::from_utf8_unchecked(left_word_slice) };
                        *current_counts.get_mut(left_word).unwrap() -= 1;
                        words_in_window -= 1;
                        left += word_len;
                    }
                } else {
                    current_counts.clear();
                    words_in_window = 0;
                    left = right + word_len;
                }
            }
        }

        result
    }
}