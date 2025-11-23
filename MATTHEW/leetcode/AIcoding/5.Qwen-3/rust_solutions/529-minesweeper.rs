struct Solution;

impl Solution {
    pub fn update_board(mut board: Vec<Vec<char>>, click: Vec<i32>) -> Vec<Vec<char>> {
        let (row, col) = (click[0] as usize, click[1] as usize);

        if board[row][col] == 'M' {
            board[row][col] = 'X';
            return board;
        }

        Self::dfs(&mut board, row, col);

        return board;
    }

    fn dfs(board: &mut Vec<Vec<char>>, row: usize, col: usize) {
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];
        let mine_count = Self::count_mines(board, row, col);

        if mine_count > 0 {
            board[row][col] = (b'0' + mine_count) as char;
            return;
        }

        board[row][col] = 'B';

        for &(dx, dy) in &directions {
            let new_row = row as i32 + dx;
            let new_col = col as i32 + dy;

            if new_row >= 0 && new_row < board.len() as i32 && new_col >= 0 && new_col < board[0].len() as i32 {
                let (new_row, new_col) = (new_row as usize, new_col as usize);
                if board[new_row][new_col] == 'M' || board[new_row][new_col] == 'X' {
                    continue;
                }
                Self::dfs(board, new_row, new_col);
            }
        }
    }

    fn count_mines(board: &Vec<Vec<char>>, row: usize, col: usize) -> i32 {
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];
        let mut count = 0;

        for &(dx, dy) in &directions {
            let new_row = row as i32 + dx;
            let new_col = col as i32 + dy;

            if new_row >= 0 && new_row < board.len() as i32 && new_col >= 0 && new_col < board[0].len() as i32 {
                let (new_row, new_col) = (new_row as usize, new_col as usize);
                if board[new_row][new_col] == 'M' || board[new_row][new_col] == 'X' {
                    count += 1;
                }
            }
        }

        return count;
    }
}