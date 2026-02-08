use std::collections::HashMap;

#[derive(Default)]
struct TrieNode {
    children: HashMap<char, TrieNode>,
    is_word: bool,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: HashMap::new(),
            is_word: false,
        }
    }
}

struct WordDictionary {
    root: TrieNode,
}

impl WordDictionary {
    fn new() -> Self {
        WordDictionary {
            root: TrieNode::new(),
        }
    }

    fn add_word(&mut self, word: String) {
        let mut node = &mut self.root;
        for c in word.chars() {
            node = node.children.entry(c).or_insert_with(TrieNode::new);
        }
        node.is_word = true;
    }

    fn search(&self, word: String) -> bool {
        self.search_helper(&self.root, word.chars().collect())
    }

    fn search_helper(&self, node: &TrieNode, chars: Vec<char>) -> bool {
        let mut current_node = node;
        for (i, &c) in chars.iter().enumerate() {
            if c == '.' {
                for child in current_node.children.values() {
                    if self.search_helper(child, chars[i + 1..].to_vec()) {
                        return true;
                    }
                }
                return false;
            } else {
                if let Some(child) = current_node.children.get(&c) {
                    current_node = child;
                } else {
                    return false;
                }
            }
        }
        current_node.is_word
    }
}