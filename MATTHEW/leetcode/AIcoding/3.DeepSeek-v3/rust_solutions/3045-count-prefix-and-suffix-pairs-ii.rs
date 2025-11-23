use std::collections::HashMap;

struct TrieNode {
    children: HashMap<char, TrieNode>,
    count: i32,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: HashMap::new(),
            count: 0,
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

    fn insert(&mut self, word: &str) -> i32 {
        let mut node = &mut self.root;
        let n = word.len();
        let mut res = 0;
        for (i, c) in word.chars().enumerate() {
            node = node.children.entry(c).or_insert_with(TrieNode::new);
            if word[n - i - 1..].starts_with(&word[..i + 1]) {
                res += node.count;
            }
        }
        node.count += 1;
        res
    }
}

impl Solution {
    pub fn count_prefix_suffix_pairs(words: Vec<String>) -> i64 {
        let mut trie = Trie::new();
        let mut res = 0;
        for word in words.into_iter().rev() {
            res += trie.insert(&word) as i64;
        }
        res
    }
}