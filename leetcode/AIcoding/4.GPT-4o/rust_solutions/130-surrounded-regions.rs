impl Solution {
    pub fn solve(board: &mut Vec<Vec<char>>) {
        if board.is_empty() || board[0].is_empty() {
            return;
        }

        let rows = board.len();
        let cols = board[0].len();

        let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

        fn dfs(board: &mut Vec<Vec<char>>, r: isize, c: isize) {
            if r < 0 || r >= board.len() as isize || c < 0 || c >= board[0].len() as isize || board[r as usize][c as usize] != 'O' {
                return;
            }
            board[r as usize][c as usize] = 'E';
            for (dr, dc) in directions.iter() {
                dfs(board, r + dr, c + dc);
            }
        }

        for r in 0..rows {
            if board[r][0] == 'O' {
                dfs(board, r as isize, 0);
            }
            if board[r][cols - 1] == 'O' {
                dfs(board, r as isize, (cols - 1) as isize);
            }
        }

        for c in 0..cols {
            if board[0][c] == 'O' {
                dfs(board, 0, c as isize);
            }
            if board[rows - 1][c] == 'O' {
                dfs(board, (rows - 1) as isize, c as isize);
            }
        }

        for r in 0..rows {
            for c in 0..cols {
                if board[r][c] == 'O' {
                    board[r][c] = 'X';
                } else if board[r][c] == 'E' {
                    board[r][c] = 'O';
                }
            }
        }
    }
}