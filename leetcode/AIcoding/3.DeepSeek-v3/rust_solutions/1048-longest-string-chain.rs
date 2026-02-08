use std::collections::HashMap;

impl Solution {
    pub fn longest_str_chain(words: Vec<String>) -> i32 {
        let mut words = words;
        words.sort_by_key(|s| s.len());
        let mut dp = HashMap::new();
        let mut max_chain = 1;

        for word in words {
            let mut current_max = 1;
            for i in 0..word.len() {
                let predecessor = format!("{}{}", &word[0..i], &word[i + 1..]);
                if let Some(&len) = dp.get(&predecessor) {
                    current_max = current_max.max(len + 1);
                }
            }
            dp.insert(word, current_max);
            max_chain = max_chain.max(current_max);
        }

        max_chain
    }
}