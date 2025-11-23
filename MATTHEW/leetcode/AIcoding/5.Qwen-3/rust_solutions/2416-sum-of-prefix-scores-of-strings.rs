impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn prefix_scores(strings: Vec<String>) -> Vec<i32> {
        let mut trie = Trie::new();
        for s in &strings {
            trie.insert(s);
        }

        let mut result = Vec::with_capacity(strings.len());
        for s in &strings {
            result.push(trie.count_prefixes(s));
        }

        result
    }
}

struct Trie {
    children: HashMap<char, Trie>,
    count: i32,
}

impl Trie {
    fn new() -> Self {
        Trie {
            children: HashMap::new(),
            count: 0,
        }
    }

    fn insert(&mut self, s: &str) {
        let mut node = self;
        for c in s.chars() {
            node = node.children.entry(c).or_insert(Trie::new());
            node.count += 1;
        }
    }

    fn count_prefixes(&self, s: &str) -> i32 {
        let mut node = self;
        let mut total = 0;
        for c in s.chars() {
            if let Some(child) = node.children.get(&c) {
                total += child.count;
                node = child;
            } else {
                break;
            }
        }
        total
    }
}
}