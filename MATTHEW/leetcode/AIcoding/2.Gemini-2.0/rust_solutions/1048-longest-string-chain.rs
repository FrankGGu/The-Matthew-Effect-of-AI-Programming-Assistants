use std::collections::HashMap;

impl Solution {
    pub fn longest_str_chain(words: Vec<String>) -> i32 {
        let mut words = words;
        words.sort_by(|a, b| a.len().cmp(&b.len()));
        let mut dp: HashMap<String, i32> = HashMap::new();
        let mut max_len = 0;

        for word in words {
            let mut current_len = 1;
            for i in 0..word.len() {
                let mut predecessor = word.clone();
                predecessor.remove(i);
                if let Some(&len) = dp.get(&predecessor) {
                    current_len = std::cmp::max(current_len, len + 1);
                }
            }
            dp.insert(word.clone(), current_len);
            max_len = std::cmp::max(max_len, current_len);
        }

        max_len
    }
}