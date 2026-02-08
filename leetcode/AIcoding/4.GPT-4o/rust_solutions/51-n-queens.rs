pub struct Solution;

impl Solution {
    pub fn solve_n_queens(n: i32) -> Vec<Vec<String>> {
        let mut res = Vec::new();
        let mut board = vec![vec!['.'; n as usize]; n as usize];
        Self::backtrack(&mut res, &mut board, 0, n);
        res
    }

    fn backtrack(res: &mut Vec<Vec<String>>, board: &mut Vec<Vec<char>>, row: i32, n: i32) {
        if row == n {
            res.push(board.iter().map(|r| r.iter().collect()).collect());
            return;
        }
        for col in 0..n {
            if Self::is_valid(board, row, col) {
                board[row as usize][col as usize] = 'Q';
                Self::backtrack(res, board, row + 1, n);
                board[row as usize][col as usize] = '.';
            }
        }
    }

    fn is_valid(board: &Vec<Vec<char>>, row: i32, col: i32) -> bool {
        for i in 0..row {
            if board[i as usize][col as usize] == 'Q' {
                return false;
            }
            if col - (row - i).abs() >= 0 && board[i as usize][(col - (row - i).abs()) as usize] == 'Q' {
                return false;
            }
            if col + (row - i) < board.len() as i32 && board[i as usize][(col + (row - i)) as usize] == 'Q' {
                return false;
            }
        }
        true
    }
}