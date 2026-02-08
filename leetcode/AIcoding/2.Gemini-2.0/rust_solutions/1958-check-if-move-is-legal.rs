impl Solution {
    pub fn check_move(board: Vec<Vec<char>>, r_move: i32, c_move: i32, color: char) -> bool {
        let rows = board.len();
        let cols = board[0].len();
        let r = r_move as usize;
        let c = c_move as usize;

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)];

        for &(dr, dc) in &directions {
            let mut i = r as i32 + dr;
            let mut j = c as i32 + dc;
            let mut count = 0;

            while i >= 0 && i < rows as i32 && j >= 0 && j < cols as i32 {
                let row = i as usize;
                let col = j as usize;

                if board[row][col] == '.' {
                    break;
                }

                if board[row][col] != color {
                    count += 1;
                } else {
                    if count >= 1 {
                        return true;
                    }
                    break;
                }

                i += dr;
                j += dc;
            }
        }

        false
    }
}