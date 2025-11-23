impl Solution {
    pub fn solve_sudoku(board: &mut Vec<Vec<char>>) {
        Self::backtrack(board, 0, 0);
    }

    fn backtrack(board: &mut Vec<Vec<char>>, row: usize, col: usize) -> bool {
        if row == 9 {
            return true;
        }

        let next_row = if col == 8 { row + 1 } else { row };
        let next_col = if col == 8 { 0 } else { col + 1 };

        if board[row][col] != '.' {
            return Self::backtrack(board, next_row, next_col);
        }

        for digit_char_val in b'1'..=b'9' {
            let digit = digit_char_val as char;
            if Self::is_valid(board, row, col, digit) {
                board[row][col] = digit;
                if Self::backtrack(board, next_row, next_col) {
                    return true;
                }
                board[row][col] = '.';
            }
        }
        false
    }

    fn is_valid(board: &Vec<Vec<char>>, row: usize, col: usize, digit: char) -> bool {
        for c in 0..9 {
            if board[row][c] == digit {
                return false;
            }
        }

        for r in 0..9 {
            if board[r][col] == digit {
                return false;
            }
        }

        let start_row = (row / 3) * 3;
        let start_col = (col / 3) * 3;
        for r_offset in 0..3 {
            for c_offset in 0..3 {
                if board[start_row + r_offset][start_col + c_offset] == digit {
                    return false;
                }
            }
        }
        true
    }
}