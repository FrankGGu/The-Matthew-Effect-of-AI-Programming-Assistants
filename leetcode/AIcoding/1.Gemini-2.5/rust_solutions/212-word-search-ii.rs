struct TrieNode {
    children: [Option<Box<TrieNode>>; 26],
    word: Option<String>,
}

impl TrieNode {
    fn new() -> Self {
        TrieNode {
            children: std::array::from_fn(|_| None),
            word: None,
        }
    }

    fn insert(&mut self, word: String) {
        let mut curr = self;
        for ch in word.chars() {
            let idx = (ch as u8 - b'a') as usize;
            curr = curr.children[idx].get_or_insert_with(|| Box::new(TrieNode::new()));
        }
        curr.word = Some(word);
    }
}

impl Solution {
    pub fn find_words(board: Vec<Vec<char>>, words: Vec<String>) -> Vec<String> {
        let m = board.len() as i32;
        let n = board[0].len() as i32;

        let mut root = TrieNode::new();
        for word in words {
            root.insert(word);
        }

        let mut result_vec = Vec::new();
        let mut board_mut = board;

        for r in 0..m {
            for c in 0..n {
                Self::dfs(r, c, &mut board_mut, &mut root, &mut result_vec, m, n);
            }
        }

        result_vec
    }

    fn dfs(
        r: i32,
        c: i32,
        board: &mut Vec<Vec<char>>,
        node: &mut TrieNode,
        result: &mut Vec<String>,
        m: i32,
        n: i32,
    ) {
        if r < 0 || r >= m || c < 0 || c >= n {
            return;
        }

        let ch = board[r as usize][c as usize];
        if ch == '#' {
            return;
        }

        let idx = (ch as u8 - b'a') as usize;

        let Some(next_node) = node.children[idx].as_mut() else {
            return;
        };

        if let Some(word) = next_node.word.take() {
            result.push(word);
        }

        board[r as usize][c as usize] = '#';

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let nr = r + dr[i];
            let nc = c + dc[i];
            Self::dfs(nr, nc, board, next_node, result, m, n);
        }

        board[r as usize][c as usize] = ch;
    }
}