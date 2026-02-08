use std::collections::HashMap;

struct TrieNode {
    children: HashMap<char, TrieNode>,
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
        let mut curr = &mut self.root;
        for ch in word.chars() {
            curr = curr.children.entry(ch).or_insert_with(TrieNode::new);
        }
        curr.is_end_of_word = true;
    }

    fn find_shortest_root(&self, word: &str) -> Option<String> {
        let mut curr = &self.root;
        let mut current_prefix = String::new();
        for ch in word.chars() {
            if let Some(node) = curr.children.get(&ch) {
                current_prefix.push(ch);
                if node.is_end_of_word {
                    return Some(current_prefix);
                }
                curr = node;
            } else {
                return None;
            }
        }
        None
    }
}

impl Solution {
    pub fn replace_words(dictionary: Vec<String>, sentence: String) -> String {
        let mut trie = Trie::new();
        for word in dictionary {
            trie.insert(&word);
        }

        let mut result_words = Vec::new();
        for s_word in sentence.split_whitespace() {
            if let Some(root) = trie.find_shortest_root(s_word) {
                result_words.push(root);
            } else {
                result_words.push(s_word.to_string());
            }
        }

        result_words.join(" ")
    }
}