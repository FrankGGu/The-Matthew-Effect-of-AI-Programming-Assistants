use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn minimum_moves(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();

        // State: (row, col, orientation)
        // (row, col) represents the top-left cell of the snake.
        // orientation: 0 for horizontal, 1 for vertical.
        // If horizontal: cells are (r, c) and (r, c+1)
        // If vertical: cells are (r, c) and (r+1, c)

        // Target state: (n-1, n-2, 0)
        // This means the snake occupies cells (n-1, n-2) and (n-1, n-1), horizontally.

        let mut queue: VecDeque<(usize, usize, usize, i32)> = VecDeque::new();
        let mut visited: HashSet<(usize, usize, usize)> = HashSet::new();

        // Initial state: snake at (0,0) and (0,1), horizontal, 0 moves.
        queue.push_back((0, 0, 0, 0));
        visited.insert((0, 0, 0));

        while let Some((r, c, orientation, moves)) = queue.pop_front() {
            // Check if target is reached
            if r == n - 1 && c == n - 2 && orientation == 0 {
                return moves;
            }

            // Move Right
            if orientation == 0 { // Horizontal: (r, c) and (r, c+1)
                // New position: (r, c+1) and (r, c+2)
                if c + 2 < n && grid[r][c + 2] == 0 {
                    let next_state = (r, c + 1, 0);
                    if visited.insert(next_state) {
                        queue.push_back((next_state.0, next_state.1, next_state.2, moves + 1));
                    }
                }
            } else { // Vertical: (r, c) and (r+1, c)
                // New position: (r, c+1) and (r+1, c+1)
                if c + 1 < n && grid[r][c + 1] == 0 && grid[r + 1][c + 1] == 0 {
                    let next_state = (r, c + 1, 1);
                    if visited.insert(next_state) {
                        queue.push_back((next_state.0, next_state.1, next_state.2, moves + 1));
                    }
                }
            }

            // Move Down
            if orientation == 0 { // Horizontal: (r, c) and (r, c+1)
                // New position: (r+1, c) and (r+1, c+1)
                if r + 1 < n && grid[r + 1][c] == 0 && grid[r + 1][c + 1] == 0 {
                    let next_state = (r + 1, c, 0);
                    if visited.insert(next_state) {
                        queue.push_back((next_state.0, next_state.1, next_state.2, moves + 1));
                    }
                }
            } else { // Vertical: (r, c) and (r+1, c)
                // New position: (r+1, c) and (r+2, c)
                if r + 2 < n && grid[r + 2][c] == 0 {
                    let next_state = (r + 1, c, 1);
                    if visited.insert(next_state) {
                        queue.push_back((next_state.0, next_state.1, next_state.2, moves + 1));
                    }
                }
            }

            // Rotations
            if orientation == 0 { // Horizontal: (r, c) and (r, c+1)
                // Rotate Clockwise to (r, c) and (r+1, c) (vertical)
                // Requires cells (r+1, c) and (r+1, c+1) to be empty
                if r + 1 < n && grid[r + 1][c] == 0 && grid[r + 1][c + 1] == 0 {
                    let next_state = (r, c, 1); // New orientation is vertical
                    if visited.insert(next_state) {
                        queue.push_back((next_state.0, next_state.1, next_state.2, moves + 1));
                    }
                }
            } else { // Vertical: (r, c) and (r+1, c)
                // Rotate Counter-Clockwise to (r, c) and (r, c+1) (horizontal)
                // Requires cells (r, c+1) and (r+1, c+1) to be empty
                if c + 1 < n && grid[r][c + 1] == 0 && grid[r + 1][c + 1] == 0 {
                    let next_state = (r, c, 0); // New orientation is horizontal
                    if visited.insert(next_state) {
                        queue.push_back((next_state.0, next_state.1, next_state.2, moves + 1));
                    }
                }
            }
        }

        // If target is not reachable
        -1
    }
}