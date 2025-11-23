struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    is_end_of_word: bool,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: std::array::from_fn(|_| None),
            is_end_of_word: false,
        }
    }

    fn insert(&mut self, word: &str) {
        let mut curr = self;
        for c in word.chars() {
            let idx = (c as u8 - b'a') as usize;
            curr = curr.children[idx].get_or_insert_with(Box::new);
        }
        curr.is_end_of_word = true;
    }
}

impl Solution {
    pub fn min_valid_strings_to_form_target_ii(target: String, words: Vec<String>) -> i32 {
        let n = target.len();
        let target_bytes = target.as_bytes();

        let mut trie_root = TrieNode::new();
        for word in &words {
            trie_root.insert(word);
        }

        let mut is_valid_concat = vec![vec![false; n + 1]; n + 1];

        for i in 0..n {
            let mut dp_segment = vec![false; n + 1];
            dp_segment[i] = true;

            for k in i..n {
                if !dp_segment[k] {
                    continue;
                }

                let mut curr_trie_node = &trie_root;
                for l in k..n {
                    let char_idx = (target_bytes[l] - b'a') as usize;
                    if let Some(node) = curr_trie_node.children[char_idx].as_deref() {
                        curr_trie_node = node;
                        if curr_trie_node.is_end_of_word {
                            dp_segment[l + 1] = true;
                        }
                    } else {
                        break;
                    }
                }
            }

            for j in i + 1..=n {
                is_valid_concat[i][j] = dp_segment[j];
            }
        }

        let mut dp = vec![std::i32::MAX; n + 1];
        dp[0] = 0;

        for i in 1..=n {
            for j in 0..i {
                if is_valid_concat[j][i] {
                    if dp[j] != std::i32::MAX {
                        dp[i] = dp[i].min(dp[j] + 1);
                    }
                }
            }
        }

        if dp[n] == std::i32::MAX {
            -1
        } else {
            dp[n]
        }
    }
}