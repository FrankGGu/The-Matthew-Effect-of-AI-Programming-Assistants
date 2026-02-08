use std::collections::VecDeque;

struct TrieNode {
    children: [usize; 26],
    is_end_of_word: bool,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: [0; 26],
            is_end_of_word: false,
        }
    }
}

struct StreamChecker {
    trie_nodes: Vec<TrieNode>,
    stream: VecDeque<char>,
    max_word_len: usize,
}

impl StreamChecker {
    fn new(words: Vec<String>) -> Self {
        let mut trie_nodes = Vec::new();
        trie_nodes.push(TrieNode::new());

        let mut max_word_len = 0;

        for word in words {
            max_word_len = max_word_len.max(word.len());
            let mut current_node_idx = 0;
            for c in word.chars().rev() {
                let idx = (c as u8 - b'a') as usize;
                if trie_nodes[current_node_idx].children[idx] == 0 {
                    trie_nodes.push(TrieNode::new());
                    let new_node_idx = trie_nodes.len() - 1;
                    trie_nodes[current_node_idx].children[idx] = new_node_idx;
                    current_node_idx = new_node_idx;
                } else {
                    current_node_idx = trie_nodes[current_node_idx].children[idx];
                }
            }
            trie_nodes[current_node_idx].is_end_of_word = true;
        }

        StreamChecker {
            trie_nodes,
            stream: VecDeque::new(),
            max_word_len,
        }
    }

    fn query(&mut self, letter: char) -> bool {
        self.stream.push_back(letter);

        if self.stream.len() > self.max_word_len {
            self.stream.pop_front();
        }

        let mut current_node_idx = 0;
        for &c in self.stream.iter().rev() {
            let idx = (c as u8 - b'a') as usize;
            let next_node_idx = self.trie_nodes[current_node_idx].children[idx];

            if next_node_idx == 0 {
                return false;
            }

            current_node_idx = next_node_idx;
            if self.trie_nodes[current_node_idx].is_end_of_word {
                return true;
            }
        }
        false
    }
}