struct Solution;

impl Solution {
    pub fn total_n_queens(n: i32) -> i32 {
        let mut result = 0;
        let mut board = vec![vec!['.'; n as usize]; n as usize];
        Self::backtrack(&mut board, 0, &mut result);
        result
    }

    fn backtrack(board: &mut Vec<Vec<char>>, row: i32, result: &mut i32) {
        if row == board.len() as i32 {
            *result += 1;
            return;
        }

        for col in 0..board.len() {
            if Self::is_valid(board, row, col as i32) {
                board[row as usize][col] = 'Q';
                Self::backtrack(board, row + 1, result);
                board[row as usize][col] = '.';
            }
        }
    }

    fn is_valid(board: &Vec<Vec<char>>, row: i32, col: i32) -> bool {
        for i in 0..row {
            if board[i as usize][col as usize] == 'Q' {
                return false;
            }
        }

        let (mut r, mut c) = (row - 1, col - 1);
        while r >= 0 && c >= 0 {
            if board[r as usize][c as usize] == 'Q' {
                return false;
            }
            r -= 1;
            c -= 1;
        }

        let (mut r, mut c) = (row - 1, col + 1);
        while r >= 0 && c < board.len() as i32 {
            if board[r as usize][c as usize] == 'Q' {
                return false;
            }
            r -= 1;
            c += 1;
        }

        true
    }
}