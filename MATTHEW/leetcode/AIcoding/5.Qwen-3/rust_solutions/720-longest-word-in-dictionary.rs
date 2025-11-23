impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn longest_word(mut words: Vec<String>) -> String {
        words.sort_unstable();
        let mut trie = Trie::new();
        for word in &words {
            trie.insert(word.clone());
        }
        let mut result = String::new();
        for word in &words {
            if trie.is_valid(word) && word.len() > result.len() {
                result = word.clone();
            }
        }
        result
    }
}

struct Trie {
    children: HashMap<char, Trie>,
    is_end: bool,
}

impl Trie {
    fn new() -> Self {
        Trie {
            children: HashMap::new(),
            is_end: false,
        }
    }

    fn insert(&mut self, word: String) {
        let mut node = self;
        for c in word.chars() {
            node = node.children.entry(c).or_insert_with(Trie::new);
        }
        node.is_end = true;
    }

    fn is_valid(&self, word: &str) -> bool {
        let mut node = self;
        for c in word.chars() {
            if let Some(child) = node.children.get(&c) {
                node = child;
                if !node.is_end {
                    return false;
                }
            } else {
                return false;
            }
        }
        true
    }
}
}