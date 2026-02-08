pub fn valid_tic_tac_toe(board: Vec<String>) -> bool {
    let mut x_count = 0;
    let mut o_count = 0;

    for row in &board {
        for &c in row.as_bytes() {
            if c == b'X' {
                x_count += 1;
            } else if c == b'O' {
                o_count += 1;
            }
        }
    }

    if x_count < o_count || x_count > o_count + 1 {
        return false;
    }

    let x_win = (0..3).any(|i| (board[i].chars().nth(0) == Some('X') && board[i].chars().nth(1) == Some('X') && board[i].chars().nth(2) == Some('X')) ||
                             (board[0].chars().nth(i) == Some('X') && board[1].chars().nth(i) == Some('X') && board[2].chars().nth(i) == Some('X')));
    let o_win = (0..3).any(|i| (board[i].chars().nth(0) == Some('O') && board[i].chars().nth(1) == Some('O') && board[i].chars().nth(2) == Some('O')) ||
                             (board[0].chars().nth(i) == Some('O') && board[1].chars().nth(i) == Some('O') && board[2].chars().nth(i) == Some('O')));

    if x_win && o_win {
        return false;
    }
    if x_win && x_count != o_count + 1 {
        return false;
    }
    if o_win && x_count != o_count {
        return false;
    }

    true
}