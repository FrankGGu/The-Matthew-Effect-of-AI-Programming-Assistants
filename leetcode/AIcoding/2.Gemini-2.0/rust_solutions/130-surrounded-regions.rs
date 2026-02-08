impl Solution {
    pub fn solve(board: &mut Vec<Vec<char>>) {
        let m = board.len();
        if m == 0 {
            return;
        }
        let n = board[0].len();

        for i in 0..m {
            if board[i][0] == 'O' {
                Self::dfs(board, i, 0);
            }
            if board[i][n - 1] == 'O' {
                Self::dfs(board, i, n - 1);
            }
        }

        for j in 0..n {
            if board[0][j] == 'O' {
                Self::dfs(board, 0, j);
            }
            if board[m - 1][j] == 'O' {
                Self::dfs(board, m - 1, j);
            }
        }

        for i in 0..m {
            for j in 0..n {
                if board[i][j] == 'O' {
                    board[i][j] = 'X';
                } else if board[i][j] == 'T' {
                    board[i][j] = 'O';
                }
            }
        }
    }

    fn dfs(board: &mut Vec<Vec<char>>, i: usize, j: usize) {
        let m = board.len();
        let n = board[0].len();

        if i < 0 || i >= m || j < 0 || j >= n || board[i][j] != 'O' {
            return;
        }

        board[i][j] = 'T';

        Self::dfs(board, i + 1, j);
        Self::dfs(board, i - 1, j);
        Self::dfs(board, i, j + 1);
        Self::dfs(board, i, j - 1);
    }
}