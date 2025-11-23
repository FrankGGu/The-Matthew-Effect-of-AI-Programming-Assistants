impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_cost(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dist = vec![vec![i32::MAX; n]; m];
        let mut queue = VecDeque::new();
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        dist[0][0] = 0;
        queue.push_back((0, 0));

        while let Some((i, j)) = queue.pop_front() {
            if i == m - 1 && j == n - 1 {
                return dist[i][j];
            }

            for &(di, dj) in &directions {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;

                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    let cost = if grid[i][j] == 1 { 0 } else { 1 };

                    if dist[ni][nj] > dist[i][j] + cost {
                        dist[ni][nj] = dist[i][j] + cost;
                        queue.push_back((ni, nj));
                    }
                }
            }
        }

        dist[m-1][n-1]
    }
}
}