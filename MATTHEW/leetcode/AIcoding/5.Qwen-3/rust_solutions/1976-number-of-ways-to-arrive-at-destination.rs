impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn count_paths(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut dist = vec![vec![-1; m]; n];
        let mut count = vec![vec![0; m]; n];
        let mut q = VecDeque::new();

        for i in 0..n {
            for j in 0..m {
                if grid[i][j] == 0 {
                    dist[i][j] = 0;
                    count[i][j] = 1;
                    q.push_back((i, j));
                }
            }
        }

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((i, j)) = q.pop_front() {
            for &(di, dj) in &dirs {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < n as i32 && nj >= 0 && nj < m as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if grid[ni][nj] == 0 {
                        if dist[ni][nj] == -1 {
                            dist[ni][nj] = dist[i][j] + 1;
                            count[ni][nj] = count[i][j];
                            q.push_back((ni, nj));
                        } else if dist[ni][nj] == dist[i][j] + 1 {
                            count[ni][nj] = (count[ni][nj] + count[i][j]) % 1_000_000_007;
                        }
                    }
                }
            }
        }

        count[n-1][m-1]
    }
}
}