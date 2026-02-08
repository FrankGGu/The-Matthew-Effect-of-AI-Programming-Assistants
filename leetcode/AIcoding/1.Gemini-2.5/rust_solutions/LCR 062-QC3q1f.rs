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
            if curr.children[idx].is_none() {
                curr.children[idx] = Some(Box::new(Trie::new()));
            }
            curr = curr.children[idx].as_mut().unwrap();
        }
        curr.is_end_of_word = true;
    }

    fn search(&self, word: String) -> bool {
        let mut curr = self;
        for c in word.chars() {
            let idx = (c as u8 - b'a') as usize;
            if curr.children[idx].is_none() {
                return false;
            }
            curr = curr.children[idx].as_ref().unwrap();
        }
        curr.is_end_of_word
    }

    fn starts_with(&self, prefix: String) -> bool {
        let mut curr = self;
        for c in prefix.chars() {
            let idx = (c as u8 - b'a') as usize;
            if curr.children[idx].is_none() {
                return false;
            }
            curr = curr.children[idx].as_ref().unwrap();
        }
        true
    }
}