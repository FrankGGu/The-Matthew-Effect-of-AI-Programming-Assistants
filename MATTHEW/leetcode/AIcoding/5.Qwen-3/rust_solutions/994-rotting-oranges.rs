impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn oranges_rotting(mut grid: Vec<Vec<i32>>) -> i32 {
        let (rows, cols) = (grid.len(), grid[0].len());
        let mut queue = VecDeque::new();
        let mut fresh = 0;

        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] == 1 {
                    fresh += 1;
                } else if grid[r][c] == 2 {
                    queue.push_back((r, c));
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut time = 0;

        while !queue.is_empty() && fresh > 0 {
            for _ in 0..queue.len() {
                let (r, c) = queue.pop_front().unwrap();
                for &(dr, dc) in &directions {
                    let nr = r as i32 + dr;
                    let nc = c as i32 + dc;
                    if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                        let nr = nr as usize;
                        let nc = nc as usize;
                        if grid[nr][nc] == 1 {
                            grid[nr][nc] = 2;
                            queue.push_back((nr, nc));
                            fresh -= 1;
                        }
                    }
                }
            }
            time += 1;
        }

        if fresh == 0 {
            time
        } else {
            -1
        }
    }
}
}