impl Solution {
    pub fn valid_tic_tac_toe(board: Vec<String>) -> bool {
        let mut x_count = 0;
        let mut o_count = 0;
        for row in &board {
            for c in row.chars() {
                if c == 'X' {
                    x_count += 1;
                } else if c == 'O' {
                    o_count += 1;
                }
            }
        }

        if o_count > x_count || x_count - o_count > 1 {
            return false;
        }

        let win = |player: char, board: &Vec<String>| -> bool {
            for i in 0..3 {
                if board[i].chars().all(|c| c == player) {
                    return true;
                }
                if (0..3).all(|j| board[j].chars().nth(i).unwrap() == player) {
                    return true;
                }
            }
            if (0..3).all(|i| board[i].chars().nth(i).unwrap() == player) {
                return true;
            }
            if (0..3).all(|i| board[i].chars().nth(2 - i).unwrap() == player) {
                return true;
            }
            false
        };

        let x_wins = win('X', &board);
        let o_wins = win('O', &board);

        if x_wins && o_wins {
            return false;
        }

        if x_wins && x_count == o_count {
            return false;
        }

        if o_wins && x_count > o_count {
            return false;
        }

        true
    }
}