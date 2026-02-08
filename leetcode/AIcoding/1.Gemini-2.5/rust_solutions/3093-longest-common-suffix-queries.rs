struct Solution;

#[derive(Default)]
struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    min_word_idx: Option<i32>,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: Default::default(),
            min_word_idx: None,
        }
    }

    fn insert(&mut self, word_rev: &str, original_idx: i32) {
        let mut curr = self;
        for ch in word_rev.chars() {
            let idx = (ch as u8 - b'a') as usize;
            curr = curr.children[idx].get_or_insert_with(Default::default);
            curr.min_word_idx = match curr.min_word_idx {
                Some(idx_val) => Some(idx_val.min(original_idx)),
                None => Some(original_idx),
            };
        }
    }

    fn query(&self, query_rev: &str) -> i32 {
        let mut curr = self;
        let mut best_idx = -1;
        let mut max_len = 0;

        for (len_idx, ch) in query_rev.chars().enumerate() {
            let idx = (ch as u8 - b'a') as usize;
            if let Some(node) = &curr.children[idx] {
                curr = node;
                let current_len = (len_idx + 1) as i32;

                if let Some(node_min_idx) = curr.min_word_idx {
                    if current_len > max_len {
                        max_len = current_len;
                        best_idx = node_min_idx;
                    } else if current_len == max_len {
                        best_idx = best_idx.min(node_min_idx);
                    }
                }
            } else {
                break;
            }
        }
        best_idx
    }
}

impl Solution {
    pub fn longest_common_suffix_queries(words: Vec<String>, queries: Vec<String>) -> Vec<i32> {
        let mut trie = TrieNode::new();

        for (i, word) in words.into_iter().enumerate() {
            let reversed_word: String = word.chars().rev().collect();
            trie.insert(&reversed_word, i as i32);
        }

        let mut results = Vec::with_capacity(queries.len());
        for query in queries {
            let reversed_query: String = query.chars().rev().collect();
            results.push(trie.query(&reversed_query));
        }

        results
    }
}