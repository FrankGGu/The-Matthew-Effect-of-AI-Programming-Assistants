use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_time(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        if m == 1 && n == 1 {
            return 0;
        }

        if grid[0][1] > 1 && grid[1][0] > 1 {
            return -1;
        }

        let mut dist = vec![vec![i32::MAX; n]; m];
        dist[0][0] = 0;

        let mut pq = BinaryHeap::new();
        pq.push(Reverse((0, 0, 0)));

        let dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some(Reverse((d, r, c))) = pq.pop() {
            if d > dist[r][c] {
                continue;
            }

            for (dr, dc) in dirs {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;

                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    let wait_time = if grid[nr][nc] <= d + 1 {
                        0
                    } else {
                        (grid[nr][nc] - (d + 1) + 1) / 2
                    };

                    let new_dist = d + 1 + wait_time;

                    if new_dist < dist[nr][nc] {
                        dist[nr][nc] = new_dist;
                        pq.push(Reverse((new_dist, nr, nc)));
                    }
                }
            }
        }

        if dist[m - 1][n - 1] == i32::MAX {
            return -1;
        }

        dist[m - 1][n - 1]
    }
}