impl Solution {
    pub fn check_move(board: Vec<Vec<char>>, r_move: i32, c_move: i32, color: char) -> bool {
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];
        let r = r_move as usize;
        let c = c_move as usize;
        if board[r][c] != '.' {
            return false;
        }
        let opponent = if color == 'B' { 'W' } else { 'B' };

        for &(dr, dc) in directions.iter() {
            let mut nr = r_move + dr;
            let mut nc = c_move + dc;
            let mut found_opponent = false;
            while nr >= 0 && nr < 8 && nc >= 0 && nc < 8 {
                let nr_usize = nr as usize;
                let nc_usize = nc as usize;
                if board[nr_usize][nc_usize] == opponent {
                    found_opponent = true;
                } else if board[nr_usize][nc_usize] == color {
                    if found_opponent {
                        return true;
                    }
                    break;
                } else {
                    break;
                }
                nr += dr;
                nc += dc;
            }
        }
        false
    }
}