impl Solution {
    pub fn exist(board: Vec<Vec<char>>, word: String) -> bool {
        let rows = board.len();
        let cols = board[0].len();
        let word_bytes = word.as_bytes();

        fn dfs(board: &Vec<Vec<char>>, word_bytes: &[u8], i: usize, j: usize, index: usize, visited: &mut Vec<Vec<bool>>) -> bool {
            if index == word_bytes.len() {
                return true;
            }
            if i >= board.len() || j >= board[0].len() || visited[i][j] || board[i][j] as u8 != word_bytes[index] {
                return false;
            }
            visited[i][j] = true;
            let found = dfs(board, word_bytes, i + 1, j, index + 1, visited) ||
                        dfs(board, word_bytes, i - 1, j, index + 1, visited) ||
                        dfs(board, word_bytes, i, j + 1, index + 1, visited) ||
                        dfs(board, word_bytes, i, j - 1, index + 1, visited);
            visited[i][j] = false;
            found
        }

        for i in 0..rows {
            for j in 0..cols {
                let mut visited = vec![vec![false; cols]; rows];
                if dfs(&board, &word_bytes, i, j, 0, &mut visited) {
                    return true;
                }
            }
        }
        false
    }
}