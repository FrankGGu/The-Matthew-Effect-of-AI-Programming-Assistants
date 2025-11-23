impl Solution {
    pub fn is_valid(board: &Vec<Vec<char>>, i: i32, j: i32) -> bool {
        i >= 0 && i < board.len() as i32 && j >= 0 && j < board[0].len() as i32
    }

    pub fn solve_sudoku(board: &mut Vec<Vec<char>>) {
        Self::solve(board);
    }

    fn solve(board: &mut Vec<Vec<char>>) -> bool {
        for i in 0..9 {
            for j in 0..9 {
                if board[i][j] == '.' {
                    for c in '1'..='9' {
                        if Self::is_valid_placement(board, i, j, c) {
                            board[i][j] = c;

                            if Self::solve(board) {
                                return true;
                            } else {
                                board[i][j] = '.';
                            }
                        }
                    }
                    return false;
                }
            }
        }
        true
    }

    fn is_valid_placement(board: &Vec<Vec<char>>, row: usize, col: usize, c: char) -> bool {
        for i in 0..9 {
            if board[row][i] == c {
                return false;
            }
            if board[i][col] == c {
                return false;
            }
            if board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == c {
                return false;
            }
        }
        true
    }
}

struct Solution;