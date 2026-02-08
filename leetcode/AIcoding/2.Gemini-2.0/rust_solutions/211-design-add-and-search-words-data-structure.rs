struct WordDictionary {
    children: [Option<Box<WordDictionary>>; 26],
    is_word: bool,
}

impl WordDictionary {
    fn new() -> Self {
        WordDictionary {
            children: [None; 26],
            is_word: false,
        }
    }

    fn add_word(&mut self, word: String) {
        let mut node = self;
        for byte in word.bytes() {
            let index = (byte - b'a') as usize;
            node = node.children[index].get_or_insert_with(|| Box::new(WordDictionary::new()));
        }
        node.is_word = true;
    }

    fn search(&self, word: String) -> bool {
        self.search_recursive(&word, 0)
    }

    fn search_recursive(&self, word: &str, index: usize) -> bool {
        if index == word.len() {
            return self.is_word;
        }

        let char = word.as_bytes()[index] as char;

        if char == '.' {
            for child in &self.children {
                if let Some(node) = child {
                    if node.search_recursive(word, index + 1) {
                        return true;
                    }
                }
            }
            false
        } else {
            let idx = (char as u8 - b'a') as usize;
            if let Some(node) = &self.children[idx] {
                node.search_recursive(word, index + 1)
            } else {
                false
            }
        }
    }
}