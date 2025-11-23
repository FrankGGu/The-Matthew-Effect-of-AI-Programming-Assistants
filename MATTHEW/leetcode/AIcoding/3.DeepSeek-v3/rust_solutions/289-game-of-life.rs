impl Solution {
    pub fn game_of_life(board: &mut Vec<Vec<i32>>) {
        let m = board.len();
        if m == 0 {
            return;
        }
        let n = board[0].len();
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];

        for i in 0..m {
            for j in 0..n {
                let mut live_neighbors = 0;
                for (dx, dy) in directions.iter() {
                    let x = i as i32 + dx;
                    let y = j as i32 + dy;
                    if x >= 0 && x < m as i32 && y >= 0 && y < n as i32 {
                        live_neighbors += board[x as usize][y as usize] & 1;
                    }
                }

                if board[i][j] == 1 && (live_neighbors == 2 || live_neighbors == 3) {
                    board[i][j] |= 2;
                }
                if board[i][j] == 0 && live_neighbors == 3 {
                    board[i][j] |= 2;
                }
            }
        }

        for i in 0..m {
            for j in 0..n {
                board[i][j] >>= 1;
            }
        }
    }
}