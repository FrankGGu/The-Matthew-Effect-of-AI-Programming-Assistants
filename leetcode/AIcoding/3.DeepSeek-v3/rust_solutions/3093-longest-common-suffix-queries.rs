use std::collections::HashMap;

struct TrieNode {
    children: HashMap<char, TrieNode>,
    index: i32,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: HashMap::new(),
            index: -1,
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

    fn insert(&mut self, word: &str, idx: i32) {
        let mut node = &mut self.root;
        for c in word.chars().rev() {
            node = node.children.entry(c).or_insert_with(TrieNode::new);
            if node.index == -1 {
                node.index = idx;
            }
        }
    }

    fn search(&self, word: &str) -> i32 {
        let mut node = &self.root;
        for c in word.chars().rev() {
            if let Some(child) = node.children.get(&c) {
                node = child;
            } else {
                break;
            }
        }
        node.index
    }
}

impl Solution {
    pub fn string_indices(words_container: Vec<String>, words_query: Vec<String>) -> Vec<i32> {
        let mut trie = Trie::new();
        for (i, word) in words_container.iter().enumerate() {
            trie.insert(word, i as i32);
        }
        words_query.iter().map(|word| trie.search(word)).collect()
    }
}