impl Solution {
    pub fn game_of_life(board: &mut Vec<Vec<i32>>) {
        let m = board.len();
        if m == 0 {
            return;
        }
        let n = board[0].len();
        if n == 0 {
            return;
        }

        // Define all 8 possible directions for neighbors
        let directions = [
            (-1, -1), (-1, 0), (-1, 1), // Top row
            (0, -1),           (0, 1),  // Middle row
            (1, -1),  (1, 0),  (1, 1),  // Bottom row
        ];

        // First pass: Update cells to intermediate states
        // Use 2 to indicate a cell that was live (1) but will become dead (0).
        // Use 3 to indicate a cell that was dead (0) but will become live (1).
        // 0 and 1 remain for cells whose state doesn't change yet, or for cells
        // that were 0 and remain 0, or were 1 and remain 1.
        for r in 0..m {
            for c in 0..n {
                let mut live_neighbors = 0;

                // Count live neighbors
                for &(dr, dc) in directions.iter() {
                    let nr = r as isize + dr;
                    let nc = c as isize + dc;

                    // Check boundaries
                    if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                        let neighbor_val = board[nr as usize][nc as usize];
                        // A neighbor is considered 'live' if its original state was 1.
                        // In our intermediate states, this means it's currently 1 or 2.
                        // (1: originally live, stays live for now; 2: originally live, becomes dead)
                        if neighbor_val == 1 || neighbor_val == 2 {
                            live_neighbors += 1;
                        }
                    }
                }

                // Apply Game of Life rules
                if board[r][c] == 1 { // Current cell is live
                    if live_neighbors < 2 || live_neighbors > 3 {
                        board[r][c] = 2; // Live -> Dead (intermediate state)
                    }
                    // If live_neighbors is 2 or 3, it remains 1 (live)
                } else { // Current cell is dead (board[r][c] == 0)
                    if live_neighbors == 3 {
                        board[r][c] = 3; // Dead -> Live (intermediate state)
                    }
                    // If live_neighbors is not 3, it remains 0 (dead)
                }
            }
        }

        // Second pass: Convert intermediate states to final states
        for r in 0..m {
            for c in 0..n {
                if board[r][c] == 2 {
                    board[r][c] = 0; // Was live, became dead
                } else if board[r][c] == 3 {
                    board[r][c] = 1; // Was dead, became live
                }
            }
        }
    }
}