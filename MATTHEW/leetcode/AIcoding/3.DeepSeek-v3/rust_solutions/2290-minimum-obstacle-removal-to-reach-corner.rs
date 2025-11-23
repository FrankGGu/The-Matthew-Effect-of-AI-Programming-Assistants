use std::collections::VecDeque;

impl Solution {
    pub fn minimum_obstacles(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dist = vec![vec![i32::MAX; n]; m];
        let mut q = VecDeque::new();
        q.push_back((0, 0));
        dist[0][0] = 0;

        let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some((i, j)) = q.pop_front() {
            for &(di, dj) in dirs.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    let new_dist = dist[i][j] + grid[ni][nj];
                    if new_dist < dist[ni][nj] {
                        dist[ni][nj] = new_dist;
                        if grid[ni][nj] == 0 {
                            q.push_front((ni, nj));
                        } else {
                            q.push_back((ni, nj));
                        }
                    }
                }
            }
        }

        dist[m - 1][n - 1]
    }
}