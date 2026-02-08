impl Solution {
    pub fn update_board(mut board: Vec<Vec<char>>, click: Vec<i32>) -> Vec<Vec<char>> {
        let rows = board.len();
        if rows == 0 {
            return board;
        }
        let cols = board[0].len();
        if cols == 0 {
            return board;
        }

        let r = click[0] as usize;
        let c = click[1] as usize;

        if board[r][c] == 'M' {
            board[r][c] = 'X';
            return board;
        }

        if board[r][c] == 'E' {
            Self::dfs(&mut board, r, c, rows, cols);
        }

        board
    }

    fn dfs(board: &mut Vec<Vec<char>>, r: usize, c: usize, rows: usize, cols: usize) {
        if r >= rows || c >= cols || board[r][c] != 'E' {
            return;
        }

        let mut mine_count = 0;
        let dr = [-1, -1, -1, 0, 0, 1, 1, 1];
        let dc = [-1, 0, 1, -1, 1, -1, 0, 1];

        for i in 0..8 {
            let nr = r as isize + dr[i];
            let nc = c as isize + dc[i];

            if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                let nr_usize = nr as usize;
                let nc_usize = nc as usize;
                if board[nr_usize][nc_usize] == 'M' {
                    mine_count += 1;
                }
            }
        }

        if mine_count > 0 {
            board[r][c] = (mine_count as u8 + b'0') as char;
        } else {
            board[r][c] = 'B';
            for i in 0..8 {
                let nr = r as isize + dr[i];
                let nc = c as isize + dc[i];

                if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                    Self::dfs(board, nr as usize, nc as usize, rows, cols);
                }
            }
        }
    }
}