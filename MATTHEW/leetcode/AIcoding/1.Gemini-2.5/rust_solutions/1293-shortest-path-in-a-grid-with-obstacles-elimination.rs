use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn shortest_path(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len() as i32;
        let n = grid[0].len() as i32;

        if m == 1 && n == 1 {
            return 0;
        }

        let mut queue: VecDeque<(i32, i32, i32, i32)> = VecDeque::new();
        let mut visited: HashSet<(i32, i32, i32)> = HashSet::new();

        // (row, col, remaining_k, steps)
        queue.push_back((0, 0, k, 0));
        visited.insert((0, 0, k));

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((r, c, current_k, steps)) = queue.pop_front() {
            for &(dr, dc) in &directions {
                let nr = r + dr;
                let nc = c + dc;

                if nr >= 0 && nr < m && nc >= 0 && nc < n {
                    let next_k;
                    if grid[nr as usize][nc as usize] == 0 { // Empty cell
                        next_k = current_k;
                    } else { // Obstacle
                        next_k = current_k - 1;
                    }

                    if next_k >= 0 && !visited.contains(&(nr, nc, next_k)) {
                        if nr == m - 1 && nc == n - 1 {
                            return steps + 1;
                        }
                        visited.insert((nr, nc, next_k));
                        queue.push_back((nr, nc, next_k, steps + 1));
                    }
                }
            }
        }

        -1
    }
}