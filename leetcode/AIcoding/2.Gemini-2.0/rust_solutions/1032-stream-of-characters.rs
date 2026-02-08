struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    is_word: bool,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: [None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None],
            is_word: false,
        }
    }
}

struct StreamChecker {
    trie_root: Box<TrieNode>,
    stream: Vec<char>,
}

impl StreamChecker {

    fn new(words: Vec<String>) -> Self {
        let mut trie_root = Box::new(TrieNode::new());

        for word in words {
            let mut node = &mut trie_root;
            for &c in word.chars().rev() {
                let index = (c as u8 - b'a') as usize;
                if node.children[index].is_none() {
                    node.children[index] = Some(Box::new(TrieNode::new()));
                }
                node = node.children[index].as_mut().unwrap();
            }
            node.is_word = true;
        }

        StreamChecker {
            trie_root,
            stream: Vec::new(),
        }
    }

    fn query(&mut self, letter: char) -> bool {
        self.stream.push(letter);

        let mut node = &self.trie_root;
        for &c in self.stream.iter().rev() {
            let index = (c as u8 - b'a') as usize;
            if node.children[index].is_none() {
                return false;
            }
            node = node.children[index].as_ref().unwrap();
            if node.is_word {
                return true;
            }
        }

        false
    }
}