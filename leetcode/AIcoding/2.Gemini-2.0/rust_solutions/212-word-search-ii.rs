use std::collections::HashSet;

struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    word: Option<String>,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: [None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None],
            word: None,
        }
    }
}

struct Trie {
    root: TrieNode,
}

impl Trie {
    fn new() -> Self {
        Trie { root: TrieNode::new() }
    }

    fn insert(&mut self, word: String) {
        let mut node = &mut self.root;
        for &c in word.as_bytes() {
            let idx = (c - b'a') as usize;
            node = node.children[idx].get_or_insert_with(|| Box::new(TrieNode::new()));
        }
        node.word = Some(word);
    }
}

impl Solution {
    pub fn find_words(board: Vec<Vec<char>>, words: Vec<String>) -> Vec<String> {
        let mut trie = Trie::new();
        for word in words {
            trie.insert(word);
        }

        let mut result = HashSet::new();
        let rows = board.len();
        let cols = board[0].len();

        fn dfs(
            board: &Vec<Vec<char>>,
            row: usize,
            col: usize,
            node: &mut TrieNode,
            result: &mut HashSet<String>,
        ) {
            if row >= board.len() || col >= board[0].len() || board[row][col] == '#' {
                return;
            }

            let c = board[row][col];
            let idx = (c as u8 - b'a') as usize;

            if node.children[idx].is_none() {
                return;
            }

            let next_node = node.children[idx].as_mut().unwrap();

            if let Some(word) = &next_node.word {
                result.insert(word.clone());
            }

            let original_char = board[row][col];
            board[row][col] = '#';

            if row > 0 {
                dfs(board, row - 1, col, next_node, result);
            }
            if row < board.len() - 1 {
                dfs(board, row + 1, col, next_node, result);
            }
            if col > 0 {
                dfs(board, row, col - 1, next_node, result);
            }
            if col < board[0].len() - 1 {
                dfs(board, row, col + 1, next_node, result);
            }

            board[row][col] = original_char;
        }

        for row in 0..rows {
            for col in 0..cols {
                dfs(&board, row, col, &mut trie.root, &mut result);
            }
        }

        result.into_iter().collect()
    }
}