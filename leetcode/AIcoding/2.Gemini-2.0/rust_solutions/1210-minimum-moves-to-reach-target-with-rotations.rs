use std::collections::VecDeque;

impl Solution {
    pub fn minimum_moves(grid: Vec<Vec<i32>>, target_x: i32, target_y: i32) -> i32 {
        let n = grid.len();
        let target_x = target_x as usize;
        let target_y = target_y as usize;

        if grid[n - 1][n - 1] == 1 || grid[n - 1][n - 2] == 1 {
            return -1;
        }

        let mut visited = vec![vec![vec![false; 2]; n]; n];
        let mut queue = VecDeque::new();

        queue.push_back((0, 0, 0, 0)); // x, y, state (0: horizontal, 1: vertical), moves
        visited[0][0][0] = true;

        while let Some((x, y, state, moves)) = queue.pop_front() {
            if x == target_x && y == target_y - 1 && state == 0 {
                return moves;
            }

            // Move forward
            if state == 0 {
                if y + 2 < n && grid[x][y + 2] == 0 && !visited[x][y + 1][0] {
                    visited[x][y + 1][0] = true;
                    queue.push_back((x, y + 1, 0, moves + 1));
                }
            } else {
                if x + 2 < n && grid[x + 2][y] == 0 && !visited[x + 1][y][1] {
                    visited[x + 1][y][1] = true;
                    queue.push_back((x + 1, y, 1, moves + 1));
                }
            }

            // Move down/right
            if state == 0 {
                if x + 1 < n && grid[x + 1][y] == 0 && grid[x + 1][y + 1] == 0 && !visited[x + 1][y][0] {
                    visited[x + 1][y][0] = true;
                    queue.push_back((x + 1, y, 0, moves + 1));
                }
            } else {
                if y + 1 < n && grid[x][y + 1] == 0 && grid[x + 1][y + 1] == 0 && !visited[x][y + 1][1] {
                    visited[x][y + 1][1] = true;
                    queue.push_back((x, y + 1, 1, moves + 1));
                }
            }

            // Rotate
            if state == 0 {
                if x + 1 < n && grid[x + 1][y] == 0 && grid[x + 1][y + 1] == 0 && !visited[x][y][1] {
                    visited[x][y][1] = true;
                    queue.push_back((x, y, 1, moves + 1));
                }
            } else {
                if y + 1 < n && grid[x][y + 1] == 0 && grid[x + 1][y + 1] == 0 && !visited[x][y][0] {
                    visited[x][y][0] = true;
                    queue.push_back((x, y, 0, moves + 1));
                }
            }
        }

        -1
    }
}