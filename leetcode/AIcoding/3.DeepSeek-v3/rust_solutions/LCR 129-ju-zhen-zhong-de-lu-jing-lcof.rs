impl Solution {
    pub fn exist(board: Vec<Vec<char>>, word: String) -> bool {
        let rows = board.len();
        if rows == 0 {
            return false;
        }
        let cols = board[0].len();
        let word_chars: Vec<char> = word.chars().collect();
        let mut visited = vec![vec![false; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                if Self::dfs(&board, &word_chars, &mut visited, i, j, 0) {
                    return true;
                }
            }
        }
        false
    }

    fn dfs(
        board: &Vec<Vec<char>>,
        word: &[char],
        visited: &mut Vec<Vec<bool>>,
        i: usize,
        j: usize,
        index: usize,
    ) -> bool {
        if index == word.len() {
            return true;
        }
        if i >= board.len() || j >= board[0].len() || visited[i][j] || board[i][j] != word[index] {
            return false;
        }

        visited[i][j] = true;
        let found = 
            (i > 0 && Self::dfs(board, word, visited, i - 1, j, index + 1)) ||
            (j > 0 && Self::dfs(board, word, visited, i, j - 1, index + 1)) ||
            (i < board.len() - 1 && Self::dfs(board, word, visited, i + 1, j, index + 1)) ||
            (j < board[0].len() - 1 && Self::dfs(board, word, visited, i, j + 1, index + 1));
        visited[i][j] = false;
        found
    }
}