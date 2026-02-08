impl Solution {
    fn check_win(board: &Vec<String>, player: char) -> bool {
        for i in 0..3 {
            if board[i].chars().nth(0).unwrap() == player &&
               board[i].chars().nth(1).unwrap() == player &&
               board[i].chars().nth(2).unwrap() == player {
                return true;
            }
        }

        for j in 0..3 {
            if board[0].chars().nth(j).unwrap() == player &&
               board[1].chars().nth(j).unwrap() == player &&
               board[2].chars().nth(j).unwrap() == player {
                return true;
            }
        }

        if board[0].chars().nth(0).unwrap() == player &&
           board[1].chars().nth(1).unwrap() == player &&
           board[2].chars().nth(2).unwrap() == player {
            return true;
        }
        if board[0].chars().nth(2).unwrap() == player &&
           board[1].chars().nth(1).unwrap() == player &&
           board[2].chars().nth(0).unwrap() == player {
            return true;
        }

        false
    }

    pub fn is_valid_tic_tac_toe(board: Vec<String>) -> bool {
        let mut x_count = 0;
        let mut o_count = 0;

        for r_str in &board {
            for c_char in r_str.chars() {
                if c_char == 'X' {
                    x_count += 1;
                } else if c_char == 'O' {
                    o_count += 1;
                }
            }
        }

        if o_count > x_count || x_count - o_count > 1 {
            return false;
        }

        let x_wins = Self::check_win(&board, 'X');
        let o_wins = Self::check_win(&board, 'O');

        if x_wins && o_wins {
            return false;
        }

        if x_wins {
            return x_count == o_count + 1;
        }

        if o_wins {
            return x_count == o_count;
        }

        true
    }
}