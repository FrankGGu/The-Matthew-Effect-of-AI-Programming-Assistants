use std::collections::HashMap;

#[derive(Default)]
struct TrieNode {
    children: HashMap<char, TrieNode>,
    count: i32,
}

impl TrieNode {
    fn new() -> Self {
        Self::default()
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
        let mut node = &mut self.root;
        for c in word.chars() {
            node = node.children.entry(c).or_insert_with(TrieNode::new);
            node.count += 1;
        }
    }

    fn get_score(&self, word: &str) -> i32 {
        let mut node = &self.root;
        let mut score = 0;
        for c in word.chars() {
            if let Some(child) = node.children.get(&c) {
                score += child.count;
                node = child;
            } else {
                break;
            }
        }
        score
    }
}

impl Solution {
    pub fn sum_prefix_scores(words: Vec<String>) -> Vec<i32> {
        let mut trie = Trie::new();
        for word in &words {
            trie.insert(word);
        }
        words.iter().map(|word| trie.get_score(word)).collect()
    }
}