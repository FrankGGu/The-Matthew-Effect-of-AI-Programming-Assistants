use std::collections::HashMap;

impl Solution {
    pub fn longest_str_chain(mut words: Vec<String>) -> i32 {
        words.sort_unstable_by_key(|s| s.len());

        let mut dp: HashMap<String, i32> = HashMap::new();
        let mut max_chain_length = 0;

        for word in words {
            let mut current_word_chain_length = 1;

            for i in 0..word.len() {
                let mut predecessor_chars: Vec<char> = word.chars().collect();
                predecessor_chars.remove(i);
                let predecessor: String = predecessor_chars.into_iter().collect();

                if let Some(&prev_len) = dp.get(&predecessor) {
                    current_word_chain_length = current_word_chain_length.max(prev_len + 1);
                }
            }

            dp.insert(word, current_word_chain_length);
            max_chain_length = max_chain_length.max(current_word_chain_length);
        }

        max_chain_length
    }
}