struct StreamChecker {
    trie: TrieNode,
    stream: Vec<char>,
}

struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    is_end: bool,
}

impl StreamChecker {
    fn new(words: Vec<String>) -> Self {
        let mut trie = TrieNode {
            children: Default::default(),
            is_end: false,
        };
        for word in words {
            let mut node = &mut trie;
            for ch in word.chars().rev() {
                let index = (ch as u8 - b'a') as usize;
                node = node.children[index].get_or_insert_with(|| Box::new(TrieNode {
                    children: Default::default(),
                    is_end: false,
                }));
            }
            node.is_end = true;
        }
        StreamChecker { trie, stream: Vec::new() }
    }

    fn query(&mut self, letter: char) -> bool {
        self.stream.push(letter);
        let mut node = &self.trie;
        for &ch in self.stream.iter().rev() {
            let index = (ch as u8 - b'a') as usize;
            if let Some(next_node) = &node.children[index] {
                if next_node.is_end {
                    return true;
                }
                node = next_node;
            } else {
                break;
            }
        }
        false
    }
}