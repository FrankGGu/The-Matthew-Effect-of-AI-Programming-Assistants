impl Solution {

use std::collections::{HashSet, VecDeque};

struct Solution;

impl Solution {
    pub fn drone_pool(grid: Vec<Vec<char>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut visited = vec![vec![false; cols]; rows];
        let mut result = 0;

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == '1' && !visited[i][j] {
                    let mut queue = VecDeque::new();
                    queue.push_back((i, j));
                    visited[i][j] = true;
                    let mut area = 0;

                    while let Some((x, y)) = queue.pop_front() {
                        area += 1;
                        for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                            let nx = x as i32 + dx;
                            let ny = y as i32 + dy;
                            if nx >= 0 && ny >= 0 && nx < rows as i32 && ny < cols as i32 {
                                let nx = nx as usize;
                                let ny = ny as usize;
                                if !visited[nx][ny] && grid[nx][ny] == '1' {
                                    visited[nx][ny] = true;
                                    queue.push_back((nx, ny));
                                }
                            }
                        }
                    }

                    result = std::cmp::max(result, area);
                }
            }
        }

        result
    }
}
}