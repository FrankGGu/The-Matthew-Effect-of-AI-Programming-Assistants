use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_obstacles(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dist = vec![vec![i32::MAX; n]; m];
        dist[0][0] = 0;

        let mut pq = BinaryHeap::new();
        pq.push(Reverse((0, 0, 0)));

        let dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some(Reverse((d, r, c))) = pq.pop() {
            if d > dist[r][c] {
                continue;
            }

            if r == m - 1 && c == n - 1 {
                return d;
            }

            for (dr, dc) in dirs {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;

                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;
                    let new_dist = d + grid[nr][nc];

                    if new_dist < dist[nr][nc] {
                        dist[nr][nc] = new_dist;
                        pq.push(Reverse((new_dist, nr, nc)));
                    }
                }
            }
        }

        -1
    }
}