use std::collections::HashMap;

struct TrieNode {
    children: HashMap<u8, TrieNode>,
    is_end_of_word: bool,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: HashMap::new(),
            is_end_of_word: false,
        }
    }
}

struct Trie {
    root: TrieNode,
}

impl Trie {
    fn new() -> Self {
        Trie {
            root: TrieNode::new(),
        }
    }

    fn insert(&mut self, word: &str) {
        let mut current_node = &mut self.root;
        for &byte in word.as_bytes() {
            current_node = current_node.children.entry(byte).or_insert_with(TrieNode::new);
        }
        current_node.is_end_of_word = true;
    }
}

fn is_concatenated_with_trie(word: &str, trie: &Trie) -> bool {
    let n = word.len();
    if n == 0 {
        return false;
    }

    let mut dp = vec![false; n + 1];
    dp[0] = true;

    let word_bytes = word.as_bytes();

    for i in 0..n {
        if !dp[i] {
            continue;
        }

        let mut current_node = &trie.root;
        for j in i..n {
            let byte = word_bytes[j];
            if let Some(node) = current_node.children.get(&byte) {
                current_node = node;
                if current_node.is_end_of_word {
                    dp[j + 1] = true;
                }
            } else {
                break;
            }
        }
    }

    dp[n]
}

impl Solution {
    pub fn find_all_concatenated_words_in_a_dict(words: Vec<String>) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        if words.is_empty() {
            return result;
        }

        let mut sorted_words = words;
        sorted_words.sort_by_key(|w| w.len());

        let mut trie = Trie::new();

        for word in sorted_words {
            if word.is_empty() {
                continue;
            }

            if is_concatenated_with_trie(&word, &trie) {
                result.push(word.clone());
            }

            trie.insert(&word);
        }

        result
    }
}