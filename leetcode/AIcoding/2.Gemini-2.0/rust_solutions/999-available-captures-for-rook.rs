impl Solution {
    pub fn num_rook_captures(board: Vec<Vec<char>>) -> i32 {
        let mut rook_row = 0;
        let mut rook_col = 0;

        for i in 0..board.len() {
            for j in 0..board[i].len() {
                if board[i][j] == 'R' {
                    rook_row = i;
                    rook_col = j;
                    break;
                }
            }
        }

        let mut captures = 0;

        // Check up
        for i in (0..rook_row).rev() {
            if board[i][rook_col] == 'B' {
                break;
            } else if board[i][rook_col] == 'p' {
                captures += 1;
                break;
            }
        }

        // Check down
        for i in rook_row + 1..board.len() {
            if board[i][rook_col] == 'B' {
                break;
            } else if board[i][rook_col] == 'p' {
                captures += 1;
                break;
            }
        }

        // Check left
        for j in (0..rook_col).rev() {
            if board[rook_row][j] == 'B' {
                break;
            } else if board[rook_row][j] == 'p' {
                captures += 1;
                break;
            }
        }

        // Check right
        for j in rook_col + 1..board[0].len() {
            if board[rook_row][j] == 'B' {
                break;
            } else if board[rook_row][j] == 'p' {
                captures += 1;
                break;
            }
        }

        captures
    }
}