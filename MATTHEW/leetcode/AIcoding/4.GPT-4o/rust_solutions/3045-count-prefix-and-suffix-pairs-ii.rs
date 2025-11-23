impl Solution {
    pub fn count_prefix_suffix_pairs(words: Vec<String>) -> i32 {
        let mut count = 0;
        let n = words.len();
        let mut map = std::collections::HashMap::new();

        for word in &words {
            let rev_word: String = word.chars().rev().collect();
            *map.entry(rev_word).or_insert(0) += 1;
        }

        for word in &words {
            let mut prefix = String::new();
            for c in word.chars() {
                prefix.push(c);
                if let Some(&suffix_count) = map.get(&prefix) {
                    count += suffix_count;
                }
            }
        }

        count
    }
}