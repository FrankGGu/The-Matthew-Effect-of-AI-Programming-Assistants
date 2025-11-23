struct Solution;

impl Solution {
    pub fn moves_to_chessboard(board: Vec<Vec<i32>>) -> i32 {
        let n = board.len();
        let mut row_swaps = 0;
        let mut col_swaps = 0;
        let mut row_count = 0;
        let mut col_count = 0;

        for i in 0..n {
            if board[i][0] != (i % 2) as i32 {
                row_swaps += 1;
            }
            if board[0][i] != (i % 2) as i32 {
                col_swaps += 1;
            }
            row_count += board[i][0];
            col_count += board[0][i];
        }

        if row_count != n / 2 && row_count != (n + 1) / 2 {
            return -1;
        }
        if col_count != n / 2 && col_count != (n + 1) / 2 {
            return -1;
        }

        if n % 2 == 0 {
            if row_swaps % 2 != 0 || col_swaps % 2 != 0 {
                return -1;
            }
            return (row_swaps / 2 + col_swaps / 2) as i32;
        } else {
            if row_swaps % 2 != 0 {
                row_swaps = n - row_swaps;
            }
            if col_swaps % 2 != 0 {
                col_swaps = n - col_swaps;
            }
            return (row_swaps / 2 + col_swaps / 2) as i32;
        }
    }
}