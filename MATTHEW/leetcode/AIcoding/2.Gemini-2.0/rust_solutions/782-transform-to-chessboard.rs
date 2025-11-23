impl Solution {
    pub fn moves_to_chessboard(board: Vec<Vec<i32>>) -> i32 {
        let n = board.len();
        let mut row_one_count = 0;
        let mut col_one_count = 0;
        let mut row_diff = 0;
        let mut col_diff = 0;

        for i in 0..n {
            for j in 0..n {
                if board[0][0] ^ board[i][j] != board[0][j] ^ board[i][0] {
                    return -1;
                }
            }
        }

        for i in 0..n {
            row_one_count += board[0][i];
            col_one_count += board[i][0];
            if board[0][i] as usize != i % 2 {
                row_diff += 1;
            }
            if board[i][0] as usize != i % 2 {
                col_diff += 1;
            }
        }

        if row_one_count != n as i32 / 2 && row_one_count != (n + 1) as i32 / 2 {
            return -1;
        }
        if col_one_count != n as i32 / 2 && col_one_count != (n + 1) as i32 / 2 {
            return -1;
        }

        let mut row_moves = row_diff / 2;
        let mut col_moves = col_diff / 2;

        if n % 2 == 1 {
            if row_diff % 2 == 1 {
                row_moves = (n - row_diff) / 2;
            }
            if col_diff % 2 == 1 {
                col_moves = (n - col_diff) / 2;
            }
        }

        row_moves + col_moves
    }
}