impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn max_moves(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut queue = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    queue.push_back((i, j, 0));
                    visited[i][j] = true;
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut max_moves = 0;

        while let Some((i, j, steps)) = queue.pop_front() {
            max_moves = max_moves.max(steps);

            for &(di, dj) in &directions {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;

                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;

                    if !visited[ni][nj] && grid[ni][nj] == 0 {
                        visited[ni][nj] = true;
                        queue.push_back((ni, nj, steps + 1));
                    }
                }
            }
        }

        max_moves
    }
}
}