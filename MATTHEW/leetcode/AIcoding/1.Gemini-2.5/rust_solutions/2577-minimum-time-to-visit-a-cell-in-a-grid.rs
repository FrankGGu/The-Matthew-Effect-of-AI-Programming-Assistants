use std::collections::BinaryHeap;
use std::cmp::{Reverse, max};

impl Solution {
    pub fn minimum_time(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        // If the grid is just one cell, we are already there at time 0.
        if m == 1 && n == 1 {
            return 0;
        }

        // Special edge case from problem description:
        // If it's impossible to move from (0,0) to any adjacent cell at time 1.
        // This implies that both grid[0][1] and grid[1][0] must be > 1.
        // This check is only relevant if both (0,1) and (1,0) are valid cells,
        // i.e., when m > 1 and n > 1.
        if m > 1 && n > 1 && grid[0][1] > 1 && grid[1][0] > 1 {
            return -1;
        }

        // Dijkstra's algorithm setup
        // dist[r][c] stores the minimum time to reach cell (r, c)
        let mut dist = vec![vec![usize::MAX; n]; m];
        dist[0][0] = 0; // Starting at (0,0) at time 0

        // Priority queue stores (time, row, col)
        // Using Reverse to make BinaryHeap a min-heap
        let mut pq = BinaryHeap::new();
        pq.push(Reverse((0, 0, 0)));

        // Directions for moving to adjacent cells (up, down, left, right)
        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some(Reverse((current_time, r, c))) = pq.pop() {
            // If we found a shorter path to (r,c) already, skip this entry
            if current_time > dist[r][c] {
                continue;
            }

            // Explore neighbors
            for i in 0..4 {
                let nr = r as isize + dr[i];
                let nc = c as isize + dc[i];

                // Check if neighbor is within grid bounds
                if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    // Calculate the time to enter the neighbor cell (nr, nc)
                    // We arrive at (nr, nc) at `current_time + 1`.
                    // If `grid[nr][nc]` is greater than `current_time + 1`, we must wait.
                    // The time taken to visit (nr, nc) is then `grid[nr][nc]`.
                    // Otherwise, we visit at `current_time + 1`.
                    let arrival_time_at_neighbor = max(current_time + 1, grid[nr][nc] as usize);

                    // If this path is shorter, update distance and push to PQ
                    if arrival_time_at_neighbor < dist[nr][nc] {
                        dist[nr][nc] = arrival_time_at_neighbor;
                        pq.push(Reverse((arrival_time_at_neighbor, nr, nc)));
                    }
                }
            }
        }

        // After Dijkstra's, check the minimum time to reach the target cell (m-1, n-1)
        if dist[m - 1][n - 1] == usize::MAX {
            -1 // Impossible to reach
        } else {
            dist[m - 1][n - 1] as i32
        }
    }
}