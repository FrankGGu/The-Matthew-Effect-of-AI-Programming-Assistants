struct Trie {
    children: [Option<Box<Trie>>; 26],
    is_end_of_word: bool,
}

impl Trie {
    fn new() -> Self {
        Trie {
            children: std::array::from_fn(|_| None),
            is_end_of_word: false,
        }
    }

    fn insert(&mut self, word: String) {
        let mut curr = self;
        for c in word.chars() {
            let idx = (c as u8 - b'a') as usize;
            curr = curr.children[idx].get_or_insert_with(|| Box::new(Trie::new()));
        }
        curr.is_end_of_word = true;
    }

    fn search(&self, word: String) -> bool {
        let mut curr = self;
        for c in word.chars() {
            let idx = (c as u8 - b'a') as usize;
            if let Some(node) = &curr.children[idx] {
                curr = node;
            } else {
                return false;
            }
        }
        curr.is_end_of_word
    }

    fn starts_with(&self, prefix: String) -> bool {
        let mut curr = self;
        for c in prefix.chars() {
            let idx = (c as u8 - b'a') as usize;
            if let Some(node) = &curr.children[idx] {
                curr = node;
            } else {
                return false;
            }
        }
        true
    }
}