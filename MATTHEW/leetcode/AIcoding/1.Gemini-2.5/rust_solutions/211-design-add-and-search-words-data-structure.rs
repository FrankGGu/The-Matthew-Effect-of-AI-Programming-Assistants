struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    is_end_of_word: bool,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: std::array::from_fn(|_| None),
            is_end_of_word: false,
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
        let mut current_node = &mut self.root;
        for c in word.chars() {
            let index = (c as u8 - b'a') as usize;
            if current_node.children[index].is_none() {
                current_node.children[index] = Some(Box::new(TrieNode::new()));
            }
            current_node = current_node.children[index].as_mut().unwrap();
        }
        current_node.is_end_of_word = true;
    }

    fn search(&self, word: String) -> bool {
        self.search_recursive(&self.root, &word, 0)
    }

    fn search_recursive(&self, node: &TrieNode, word: &str, index: usize) -> bool {
        if index == word.len() {
            return node.is_end_of_word;
        }

        let c = word.as_bytes()[index] as char;

        if c == '.' {
            for i in 0..26 {
                if let Some(child_node) = &node.children[i] {
                    if self.search_recursive(child_node, word, index + 1) {
                        return true;
                    }
                }
            }
            false
        } else {
            let i = (c as u8 - b'a') as usize;
            if let Some(child_node) = &node.children[i] {
                self.search_recursive(child_node, word, index + 1)
            } else {
                false
            }
        }
    }
}