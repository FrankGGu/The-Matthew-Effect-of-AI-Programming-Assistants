impl Solution {
    pub fn moves_to_chessboard(board: Vec<Vec<i32>>) -> i32 {
        let n = board.len();
        for i in 0..n {
            for j in 0..n {
                if board[0][0] ^ board[i][0] ^ board[0][j] ^ board[i][j] != 0 {
                    return -1;
                }
            }
        }

        let mut row_sum = 0;
        let mut col_sum = 0;
        let mut row_swap = 0;
        let mut col_swap = 0;

        for i in 0..n {
            row_sum += board[0][i];
            col_sum += board[i][0];
            if board[i][0] == (i % 2) as i32 {
                row_swap += 1;
            }
            if board[0][i] == (i % 2) as i32 {
                col_swap += 1;
            }
        }

        if row_sum != (n as i32 + 1) / 2 && row_sum != (n as i32) / 2 {
            return -1;
        }
        if col_sum != (n as i32 + 1) / 2 && col_sum != (n as i32) / 2 {
            return -1;
        }

        if n % 2 == 1 {
            if row_swap % 2 == 1 {
                row_swap = n - row_swap;
            }
            if col_swap % 2 == 1 {
                col_swap = n - col_swap;
            }
        } else {
            row_swap = std::cmp::min(row_swap, n - row_swap);
            col_swap = std::cmp::min(col_swap, n - col_swap);
        }

        ((row_swap + col_swap) / 2) as i32
    }
}