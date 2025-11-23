impl Solution {

use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn guard_city(grid: Vec<Vec<char>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut queue = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if (i == 0 || i == m - 1 || j == 0 || j == n - 1) && grid[i][j] == '0' {
                    queue.push_back((i, j));
                    visited[i][j] = true;
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((i, j)) = queue.pop_front() {
            for &(di, dj) in &directions {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if !visited[ni][nj] && grid[ni][nj] == '0' {
                        visited[ni][nj] = true;
                        queue.push_back((ni, nj));
                    }
                }
            }
        }

        let mut result = 0;
        for i in 0..m {
            for j in 0..n {
                if !visited[i][j] && grid[i][j] == '0' {
                    result += 1;
                }
            }
        }

        result
    }
}
}