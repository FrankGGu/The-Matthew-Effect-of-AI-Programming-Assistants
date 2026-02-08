impl Solution {
    pub fn sum_prefix_scores(words: Vec<String>) -> Vec<i32> {
        let mut trie = Trie::new();
        for word in &words {
            trie.insert(word);
        }
        let mut result = Vec::new();
        for word in &words {
            result.push(trie.sum_prefix_scores(word));
        }
        result
    }
}

struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    count: i32,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: [None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None],
            count: 0,
        }
    }
}

struct Trie {
    root: TrieNode,
}

impl Trie {
    fn new() -> Self {
        Trie {
            root: TrieNode::new(),
        }
    }

    fn insert(&mut self, word: &str) {
        let mut node = &mut self.root;
        for c in word.chars() {
            let index = (c as u8 - b'a') as usize;
            if node.children[index].is_none() {
                node.children[index] = Some(Box::new(TrieNode::new()));
            }
            node = node.children[index].as_mut().unwrap();
            node.count += 1;
        }
    }

    fn sum_prefix_scores(&self, word: &str) -> i32 {
        let mut node = &self.root;
        let mut sum = 0;
        for c in word.chars() {
            let index = (c as u8 - b'a') as usize;
            node = node.children[index].as_ref().unwrap();
            sum += node.count;
        }
        sum
    }
}