struct TrieNode {
    children: std::collections::HashMap<char, TrieNode>,
    is_end: bool,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: std::collections::HashMap::new(),
            is_end: false,
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
        node.is_end = true;
    }

    fn search(&self, word: String) -> bool {
        self.search_helper(&self.root, &word, 0)
    }

    fn search_helper(&self, node: &TrieNode, word: &str, index: usize) -> bool {
        if index == word.len() {
            return node.is_end;
        }
        let c = word.chars().nth(index).unwrap();
        if c == '.' {
            for child in node.children.values() {
                if self.search_helper(child, word, index + 1) {
                    return true;
                }
            }
            false
        } else {
            if let Some(child) = node.children.get(&c) {
                self.search_helper(child, word, index + 1)
            } else {
                false
            }
        }
    }
}