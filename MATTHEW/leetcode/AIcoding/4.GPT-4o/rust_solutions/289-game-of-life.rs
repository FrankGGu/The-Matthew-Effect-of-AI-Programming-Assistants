impl Solution {
    pub fn game_of_life(board: &mut Vec<Vec<i32>>) {
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)];
        let rows = board.len();
        let cols = board[0].len();

        let mut next_board = board.clone();

        for r in 0..rows {
            for c in 0..cols {
                let mut live_neighbors = 0;

                for (dr, dc) in directions.iter() {
                    let nr = r as isize + *dr;
                    let nc = c as isize + *dc;
                    if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                        live_neighbors += board[nr as usize][nc as usize];
                    }
                }

                if board[r][c] == 1 {
                    if live_neighbors < 2 || live_neighbors > 3 {
                        next_board[r][c] = 0;
                    }
                } else {
                    if live_neighbors == 3 {
                        next_board[r][c] = 1;
                    }
                }
            }
        }

        *board = next_board;
    }
}