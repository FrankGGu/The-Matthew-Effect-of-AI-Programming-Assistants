impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn minimum_moves(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut q = VecDeque::new();
        let mut visited = vec![vec![false; n]; n];

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] > 1 {
                    q.push_back((i, j, grid[i][j]));
                    visited[i][j] = true;
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut moves = 0;

        while !q.is_empty() {
            let size = q.len();
            for _ in 0..size {
                let (i, j, count) = q.pop_front().unwrap();
                if count == 1 {
                    continue;
                }
                for &(dx, dy) in &directions {
                    let ni = i as i32 + dx;
                    let nj = j as i32 + dy;
                    if ni >= 0 && ni < n as i32 && nj >= 0 && nj < n as i32 {
                        let ni = ni as usize;
                        let nj = nj as usize;
                        if !visited[ni][nj] {
                            visited[ni][nj] = true;
                            q.push_back((ni, nj, count - 1));
                        }
                    }
                }
            }
            moves += 1;
        }

        moves
    }
}
}