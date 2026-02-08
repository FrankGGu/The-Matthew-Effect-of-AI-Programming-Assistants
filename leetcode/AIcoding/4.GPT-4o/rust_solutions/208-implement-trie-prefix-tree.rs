struct Trie {
    children: Vec<Option<Box<Trie>>>,
    is_end: bool,
}

impl Trie {

    fn new() -> Self {
        Trie {
            children: vec![None; 26],
            is_end: false,
        }
    }

    fn insert(&mut self, word: String) {
        let mut node = self;
        for char in word.chars() {
            let index = (char as u8 - b'a') as usize;
            node = node.children[index].get_or_insert_with(|| Box::new(Trie::new()));
        }
        node.is_end = true;
    }

    fn search(&self, word: String) -> bool {
        let mut node = self;
        for char in word.chars() {
            let index = (char as u8 - b'a') as usize;
            match &node.children[index] {
                Some(child) => node = child,
                None => return false,
            }
        }
        node.is_end
    }

    fn starts_with(&self, prefix: String) -> bool {
        let mut node = self;
        for char in prefix.chars() {
            let index = (char as u8 - b'a') as usize;
            match &node.children[index] {
                Some(child) => node = child,
                None => return false,
            }
        }
        true
    }
}