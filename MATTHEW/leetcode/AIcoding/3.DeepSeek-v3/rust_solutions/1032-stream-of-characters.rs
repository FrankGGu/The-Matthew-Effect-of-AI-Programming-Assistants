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

struct StreamChecker {
    root: TrieNode,
    stream: Vec<char>,
}

impl StreamChecker {
    fn new(words: Vec<String>) -> Self {
        let mut root = TrieNode::new();
        for word in words {
            let mut node = &mut root;
            for c in word.chars().rev() {
                node = node.children.entry(c).or_insert_with(TrieNode::new);
            }
            node.is_word = true;
        }
        StreamChecker {
            root,
            stream: Vec::new(),
        }
    }

    fn query(&mut self, letter: char) -> bool {
        self.stream.push(letter);
        let mut node = &self.root;
        for c in self.stream.iter().rev() {
            if let Some(next_node) = node.children.get(c) {
                node = next_node;
                if node.is_word {
                    return true;
                }
            } else {
                break;
            }
        }
        false
    }
}