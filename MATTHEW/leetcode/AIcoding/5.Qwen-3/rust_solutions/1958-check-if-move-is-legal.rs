struct Solution;

impl Solution {
    pub fn is_valid_move(board: Vec<Vec<char>>, r: i32, c: i32, color: char) -> bool {
        if r < 0 || r >= 8 || c < 0 || c >= 8 {
            return false;
        }
        let opponent = if color == 'B' { 'W' } else { 'B' };
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)];
        for &(dr, dc) in &directions {
            let mut x = r + dr;
            let mut y = c + dc;
            let mut found_opponent = false;
            while x >= 0 && x < 8 && y >= 0 && y < 8 {
                if board[x as usize][y as usize] == opponent {
                    found_opponent = true;
                } else if board[x as usize][y as usize] == color {
                    if found_opponent {
                        return true;
                    } else {
                        break;
                    }
                } else {
                    break;
                }
                x += dr;
                y += dc;
            }
        }
        false
    }
}