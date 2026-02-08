impl Solution {
    pub fn sum_prefix_scores(words: Vec<String>) -> Vec<i32> {
        let mut trie = std::collections::HashMap::new();
        let mut result = vec![0; words.len()];

        for word in &words {
            let mut node = &mut trie;
            for ch in word.chars() {
                node = node.entry(ch).or_insert(std::collections::HashMap::new());
                *node.entry('$').or_insert(0) += 1;
            }
        }

        for (i, word) in words.iter().enumerate() {
            let mut node = &trie;
            let mut score = 0;
            for ch in word.chars() {
                if let Some(next_node) = node.get(&ch) {
                    score += next_node.get(&$).unwrap();
                    node = next_node;
                } else {
                    break;
                }
            }
            result[i] = score;
        }

        result
    }
}