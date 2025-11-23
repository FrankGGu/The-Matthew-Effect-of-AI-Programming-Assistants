impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn is_possible_to_escape(grid: Vec<Vec<char>>, k: i32) -> bool {
        let n = grid.len();
        let m = grid[0].len();
        let mut visited = vec![vec![false; m]; n];
        let mut queue = VecDeque::new();

        for i in 0..n {
            for j in 0..m {
                if grid[i][j] == 'S' {
                    queue.push_back((i, j, 0));
                    visited[i][j] = true;
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((x, y, steps)) = queue.pop_front() {
            if steps > k {
                continue;
            }

            if grid[x][y] == 'T' {
                return true;
            }

            for &(dx, dy) in &directions {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;

                if nx >= 0 && nx < n as i32 && ny >= 0 && ny < m as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;

                    if !visited[nx][ny] && grid[nx][ny] != 'X' {
                        visited[nx][ny] = true;
                        queue.push_back((nx, ny, steps + 1));
                    }
                }
            }
        }

        false
    }
}
}