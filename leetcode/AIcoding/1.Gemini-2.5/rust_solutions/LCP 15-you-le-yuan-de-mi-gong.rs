use std::collections::VecDeque;

impl Solution {
    pub fn min_cost(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut dist: Vec<Vec<i32>> = vec![vec![i32::MAX; n]; m];
        let mut deque: VecDeque<(usize, usize)> = VecDeque::new();

        // Directions: right, left, down, up
        // Corresponds to grid values 1, 2, 3, 4
        // dr, dc arrays are 0-indexed:
        // k=0: right (1)
        // k=1: left (2)
        // k=2: down (3)
        // k=3: up (4)
        let dr = [0, 0, 1, -1];
        let dc = [1, -1, 0, 0];

        dist[0][0] = 0;
        deque.push_front((0, 0));

        while let Some((r, c)) = deque.pop_front() {
            for k in 0..4 {
                let nr = r as i32 + dr[k];
                let nc = c as i32 + dc[k];

                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    let nr_usize = nr as usize;
                    let nc_usize = nc as usize;

                    // Calculate cost to move from (r, c) to (nr, nc)
                    // If the current cell's sign (grid[r][c]) matches the direction k+1, cost is 0.
                    // Otherwise, cost is 1 (change sign).
                    let cost = if (grid[r][c] - 1) == k as i32 { 0 } else { 1 };

                    if dist[r][c] + cost < dist[nr_usize][nc_usize] {
                        dist[nr_usize][nc_usize] = dist[r][c] + cost;
                        if cost == 0 {
                            deque.push_front((nr_usize, nc_usize));
                        } else {
                            deque.push_back((nr_usize, nc_usize));
                        }
                    }
                }
            }
        }

        dist[m - 1][n - 1]
    }
}