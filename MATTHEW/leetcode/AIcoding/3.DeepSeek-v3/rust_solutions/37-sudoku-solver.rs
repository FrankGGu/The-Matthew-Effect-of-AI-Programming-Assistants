impl Solution {
    pub fn solve_sudoku(board: &mut Vec<Vec<char>>) {
        fn is_valid(board: &Vec<Vec<char>>, row: usize, col: usize, c: char) -> bool {
            for i in 0..9 {
                if board[i][col] == c || board[row][i] == c {
                    return false;
                }
                let box_row = 3 * (row / 3) + i / 3;
                let box_col = 3 * (col / 3) + i % 3;
                if board[box_row][box_col] == c {
                    return false;
                }
            }
            true
        }

        fn backtrack(board: &mut Vec<Vec<char>>) -> bool {
            for i in 0..9 {
                for j in 0..9 {
                    if board[i][j] == '.' {
                        for c in '1'..='9' {
                            if is_valid(board, i, j, c) {
                                board[i][j] = c;
                                if backtrack(board) {
                                    return true;
                                }
                                board[i][j] = '.';
                            }
                        }
                        return false;
                    }
                }
            }
            true
        }

        backtrack(board);
    }
}