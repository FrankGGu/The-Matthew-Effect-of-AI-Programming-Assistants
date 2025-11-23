impl Solution {

use std::vec;

struct Solution;

impl Solution {
    pub fn solve_n_queens(n: i32) -> Vec<Vec<String>> {
        let mut result = vec![];
        let mut board = vec![vec!['.'; n as usize]; n as usize];
        Self::backtrack(&mut result, &mut board, 0, n);
        result
    }

    fn backtrack(result: &mut Vec<Vec<String>>, board: &mut Vec<Vec<char>>, row: i32, n: i32) {
        if row == n {
            let solution: Vec<String> = board.iter().map(|row| row.iter().collect()).collect();
            result.push(solution);
            return;
        }

        for col in 0..n {
            if Self::is_valid(board, row, col, n) {
                board[row as usize][col as usize] = 'Q';
                Self::backtrack(result, board, row + 1, n);
                board[row as usize][col as usize] = '.';
            }
        }
    }

    fn is_valid(board: &Vec<Vec<char>>, row: i32, col: i32, n: i32) -> bool {
        for i in 0..row {
            if board[i as usize][col as usize] == 'Q' {
                return false;
            }
        }

        let mut r = row - 1;
        let mut c = col - 1;
        while r >= 0 && c >= 0 {
            if board[r as usize][c as usize] == 'Q' {
                return false;
            }
            r -= 1;
            c -= 1;
        }

        let mut r = row - 1;
        let mut c = col + 1;
        while r >= 0 && c < n {
            if board[r as usize][c as usize] == 'Q' {
                return false;
            }
            r -= 1;
            c += 1;
        }

        true
    }
}
}