struct Trie {
    children: [Option<Box<Trie>>; 26],
    is_end: bool,
}

impl Trie {
    fn new() -> Self {
        Trie {
            children: [None; 26],
            is_end: false,
        }
    }

    fn insert(&mut self, word: String) {
        let mut node = self;
        for byte in word.bytes() {
            let index = (byte - b'a') as usize;
            node = node.children[index].get_or_insert_with(|| Box::new(Trie::new()));
        }
        node.is_end = true;
    }

    fn search(&self, word: String) -> bool {
        let mut node = self;
        for byte in word.bytes() {
            let index = (byte - b'a') as usize;
            match &node.children[index] {
                Some(child) => node = child,
                None => return false,
            }
        }
        node.is_end
    }

    fn starts_with(&self, prefix: String) -> bool {
        let mut node = self;
        for byte in prefix.bytes() {
            let index = (byte - b'a') as usize;
            match &node.children[index] {
                Some(child) => node = child,
                None => return false,
            }
        }
        true
    }
}