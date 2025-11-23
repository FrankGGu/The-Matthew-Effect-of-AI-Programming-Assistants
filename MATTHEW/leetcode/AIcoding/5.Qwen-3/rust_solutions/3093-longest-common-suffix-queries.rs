impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn suffix_queries(words: Vec<String>, queries: Vec<String>) -> Vec<i32> {
        let mut trie = Trie::new();
        for word in &words {
            trie.insert(word);
        }
        let mut result = Vec::with_capacity(queries.len());
        for query in queries {
            result.push(trie.query(&query));
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

    fn insert(&mut self, word: &str) {
        let mut node = self;
        for c in word.chars().rev() {
            node.count += 1;
            if !node.children.contains_key(&c) {
                node.children.insert(c, Trie::new());
            }
            node = node.children.get_mut(&c).unwrap();
        }
        node.count += 1;
    }

    fn query(&self, query: &str) -> i32 {
        let mut node = self;
        let mut result = 0;
        for c in query.chars().rev() {
            if let Some(child) = node.children.get(&c) {
                result = child.count;
                node = child;
            } else {
                return 0;
            }
        }
        result
    }
}
}