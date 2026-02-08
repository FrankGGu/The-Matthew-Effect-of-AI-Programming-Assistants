impl Solution {
    pub fn solve(board: &mut Vec<Vec<char>>) {
        if board.is_empty() {
            return;
        }
        let rows = board.len();
        let cols = board[0].len();

        for i in 0..rows {
            Self::dfs(board, i, 0);
            Self::dfs(board, i, cols - 1);
        }

        for j in 0..cols {
            Self::dfs(board, 0, j);
            Self::dfs(board, rows - 1, j);
        }

        for i in 0..rows {
            for j in 0..cols {
                if board[i][j] == 'O' {
                    board[i][j] = 'X';
                } else if board[i][j] == 'T' {
                    board[i][j] = 'O';
                }
            }
        }
    }

    fn dfs(board: &mut Vec<Vec<char>>, i: usize, j: usize) {
        if i >= board.len() || j >= board[0].len() || board[i][j] != 'O' {
            return;
        }
        board[i][j] = 'T';
        if i > 0 {
            Self::dfs(board, i - 1, j);
        }
        if i + 1 < board.len() {
            Self::dfs(board, i + 1, j);
        }
        if j > 0 {
            Self::dfs(board, i, j - 1);
        }
        if j + 1 < board[0].len() {
            Self::dfs(board, i, j + 1);
        }
    }
}