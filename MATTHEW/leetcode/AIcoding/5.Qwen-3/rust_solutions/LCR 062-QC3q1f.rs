impl Solution {

use std::collections::HashMap;

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
}

struct Solution;

impl Solution {
    fn insert(root: &mut Trie, word: String) {
        let mut node = root;
        for c in word.chars() {
            node = node.children.entry(c).or_insert(Trie::new());
        }
        node.is_end = true;
    }

    fn search(root: &Trie, word: String) -> bool {
        let mut node = root;
        for c in word.chars() {
            if let Some(child) = node.children.get(&c) {
                node = child;
            } else {
                return false;
            }
        }
        node.is_end
    }

    fn starts_with(root: &Trie, prefix: String) -> bool {
        let mut node = root;
        for c in prefix.chars() {
            if let Some(child) = node.children.get(&c) {
                node = child;
            } else {
                return false;
            }
        }
        true
    }
}
}