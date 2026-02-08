use std::collections::HashSet;

struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    word: Option<String>,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: Default::default(),
            word: None,
        }
    }
}

struct Solution;

impl Solution {
    pub fn find_words(board: Vec<Vec<char>>, words: Vec<String>) -> Vec<String> {
        let mut root = TrieNode::new();
        for word in words {
            let mut node = &mut root;
            for c in word.chars() {
                let idx = (c as u8 - b'a') as usize;
                node = node.children[idx].get_or_insert_with(|| Box::new(TrieNode::new()));
            }
            node.word = Some(word);
        }

        let mut result = HashSet::new();
        let rows = board.len();
        if rows == 0 {
            return vec![];
        }
        let cols = board[0].len();
        let mut visited = vec![vec![false; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                let c = board[i][j];
                let idx = (c as u8 - b'a') as usize;
                if let Some(child) = &root.children[idx] {
                    Self::dfs(
                        &board,
                        i,
                        j,
                        child,
                        &mut visited,
                        &mut result,
                    );
                }
            }
        }

        result.into_iter().collect()
    }

    fn dfs(
        board: &Vec<Vec<char>>,
        i: usize,
        j: usize,
        node: &TrieNode,
        visited: &mut Vec<Vec<bool>>,
        result: &mut HashSet<String>,
    ) {
        if let Some(word) = &node.word {
            result.insert(word.clone());
        }

        let rows = board.len();
        let cols = board[0].len();
        visited[i][j] = true;

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        for (di, dj) in dirs.iter() {
            let ni = i as i32 + di;
            let nj = j as i32 + dj;
            if ni >= 0 && ni < rows as i32 && nj >= 0 && nj < cols as i32 {
                let ni = ni as usize;
                let nj = nj as usize;
                if !visited[ni][nj] {
                    let c = board[ni][nj];
                    let idx = (c as u8 - b'a') as usize;
                    if let Some(child) = &node.children[idx] {
                        Self::dfs(board, ni, nj, child, visited, result);
                    }
                }
            }
        }

        visited[i][j] = false;
    }
}