use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn minimum_moves(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        let start = (0, 0, 0, 1);
        queue.push_back((start, 0));
        visited.insert(start);

        while let Some(((x1, y1, x2, y2), steps)) = queue.pop_front() {
            if x2 == n - 1 && y2 == n - 1 {
                return steps;
            }

            // Move right
            if y1 + 1 < n && y2 + 1 < n && grid[x1][y1 + 1] == 0 && grid[x2][y2 + 1] == 0 {
                let next = (x1, y1 + 1, x2, y2 + 1);
                if !visited.contains(&next) {
                    visited.insert(next);
                    queue.push_back((next, steps + 1));
                }
            }

            // Move down
            if x1 + 1 < n && x2 + 1 < n && grid[x1 + 1][y1] == 0 && grid[x2 + 1][y2] == 0 {
                let next = (x1 + 1, y1, x2 + 1, y2);
                if !visited.contains(&next) {
                    visited.insert(next);
                    queue.push_back((next, steps + 1));
                }
            }

            // Rotate clockwise (horizontal to vertical)
            if x1 == x2 && y1 + 1 == y2 && x1 + 1 < n && grid[x1 + 1][y1] == 0 && grid[x2 + 1][y2] == 0 {
                let next = (x1, y1, x1 + 1, y1);
                if !visited.contains(&next) {
                    visited.insert(next);
                    queue.push_back((next, steps + 1));
                }
            }

            // Rotate counter-clockwise (vertical to horizontal)
            if y1 == y2 && x1 + 1 == x2 && y1 + 1 < n && grid[x1][y1 + 1] == 0 && grid[x2][y2 + 1] == 0 {
                let next = (x1, y1, x1, y1 + 1);
                if !visited.contains(&next) {
                    visited.insert(next);
                    queue.push_back((next, steps + 1));
                }
            }
        }

        -1
    }
}