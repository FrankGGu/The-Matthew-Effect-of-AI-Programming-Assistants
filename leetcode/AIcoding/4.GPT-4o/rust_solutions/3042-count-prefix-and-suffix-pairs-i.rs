impl Solution {
    pub fn count_prefix_suffix_pairs(words: Vec<String>) -> i32 {
        let mut count = 0;
        let n = words.len();
        let mut suffix_set = std::collections::HashSet::new();

        for word in &words {
            suffix_set.insert(word.clone());
        }

        for i in 0..n {
            for j in 1..=words[i].len() {
                let prefix = &words[i][..j];
                if suffix_set.contains(prefix) {
                    count += 1;
                }
            }
        }

        count
    }
}