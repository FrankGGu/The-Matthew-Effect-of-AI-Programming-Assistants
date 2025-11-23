impl Solution {
    pub fn count_battleships(board: Vec<Vec<char>>) -> i32 {
        let m = board.len();
        if m == 0 {
            return 0;
        }
        let n = board[0].len();
        if n == 0 {
            return 0;
        }

        let mut count = 0;

        for r in 0..m {
            for c in 0..n {
                if board[r][c] == 'X' {
                    // Check if there is an 'X' directly above this cell
                    // If r > 0 and board[r-1][c] is 'X', then this 'X' is part of a battleship
                    // that has already been counted (or will be counted by its top-leftmost 'X').
                    if r > 0 && board[r - 1][c] == 'X' {
                        continue;
                    }
                    // Check if there is an 'X' directly to the left of this cell
                    // If c > 0 and board[r][c-1] is 'X', then this 'X' is part of a battleship
                    // that has already been counted (or will be counted by its top-leftmost 'X').
                    if c > 0 && board[r][c - 1] == 'X' {
                        continue;
                    }

                    // If neither the cell above nor the cell to the left is an 'X',
                    // then this 'X' must be the top-leftmost part of a new battleship.
                    count += 1;
                }
            }
        }
        count
    }
}