impl Solution {
    pub fn check_move(board: Vec<Vec<char>>, r_move: i32, c_move: i32, color: char) -> bool {
        let r_move = r_move as usize;
        let c_move = c_move as usize;

        if board[r_move][c_move] != '.' {
            return false;
        }

        let opponent_color = if color == 'W' { 'B' } else { 'W' };

        let dr = [-1, -1, -1, 0, 0, 1, 1, 1];
        let dc = [-1, 0, 1, -1, 1, -1, 0, 1];

        for i in 0..8 {
            let mut r = r_move as i32 + dr[i];
            let mut c = c_move as i32 + dc[i];
            let mut count_opponent_pieces = 0;

            while r >= 0 && r < 8 && c >= 0 && c < 8 {
                let current_square_char = board[r as usize][c as usize];

                if current_square_char == opponent_color {
                    count_opponent_pieces += 1;
                } else if current_square_char == color {
                    if count_opponent_pieces > 0 {
                        return true;
                    } else {
                        break; 
                    }
                } else { 
                    break;
                }

                r += dr[i];
                c += dc[i];
            }
        }

        false
    }
}