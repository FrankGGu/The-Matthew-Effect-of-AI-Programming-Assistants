use std::collections::VecDeque;

struct TrieNode {
    children: [u32; 26], // 0 means no child, otherwise index of child node in `trie_nodes`
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
    stream_history: VecDeque<char>,
    max_word_len: usize,
}

impl StreamChecker {
    fn new(words: Vec<String>) -> Self {
        let mut trie_nodes = Vec::new();
        trie_nodes.push(TrieNode::new()); // Root node at index 0

        let mut max_len = 0;

        for word in words {
            max_len = max_len.max(word.len());
            let mut current_node_idx: u32 = 0;
            for c in word.chars().rev() { // Reverse word and insert into Trie
                let idx = (c as u8 - b'a') as usize;
                if trie_nodes[current_node_idx as usize].children[idx] == 0 {
                    trie_nodes[current_node_idx as usize].children[idx] = trie_nodes.len() as u32;
                    trie_nodes.push(TrieNode::new());
                }
                current_node_idx = trie_nodes[current_node_idx as usize].children[idx];
            }
            trie_nodes[current_node_idx as usize].is_end_of_word = true;
        }

        StreamChecker {
            trie_nodes,
            stream_history: VecDeque::new(),
            max_word_len: max_len,
        }
    }

    fn query(&mut self, letter: char) -> bool {
        self.stream_history.push_back(letter);
        if self.stream_history.len() > self.max_word_len {
            self.stream_history.pop_front();
        }

        let mut current_node_idx: u32 = 0; // Start at root (index 0)
        for &c in self.stream_history.iter().rev() {
            let idx = (c as u8 - b'a') as usize;
            let next_node_idx = self.trie_nodes[current_node_idx as usize].children[idx];
            if next_node_idx == 0 {
                return false; // No path found for this suffix
            }
            current_node_idx = next_node_idx;
            if self.trie_nodes[current_node_idx as usize].is_end_of_word {
                return true; // Found a matching word as a suffix
            }
        }
        false
    }
}