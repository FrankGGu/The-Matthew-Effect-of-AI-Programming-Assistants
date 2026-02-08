use std::collections::HashSet;

impl Solution {
    pub fn longest_str_chain(words: Vec<String>) -> i32 {
        let mut words_set: HashSet<String> = words.iter().cloned().collect();
        let mut longest_chain = 0;
        let mut dp: std::collections::HashMap<String, i32> = std::collections::HashMap::new();

        for word in words.iter() {
            let mut max_length = 1;
            let word_length = word.len();
            for i in 0..word_length {
                let mut predecessor = word.clone();
                predecessor.remove(i);
                if words_set.contains(&predecessor) {
                    max_length = max_length.max(dp.get(&predecessor).unwrap_or(&0) + 1);
                }
            }
            dp.insert(word.clone(), max_length);
            longest_chain = longest_chain.max(max_length);
        }

        longest_chain
    }
}