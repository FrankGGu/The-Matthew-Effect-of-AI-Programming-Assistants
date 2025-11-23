use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_time(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        // If the target is the starting cell itself, time is 0.
        if m == 1 && n == 1 {
            return 0;
        }

        // Special condition for this problem:
        // If both adjacent cells to (0,0) require a wait time greater than 1,
        // it's impossible to reach any other cell.
        // This applies if m > 1 and n > 1.
        // A wait time > 1 means grid[r][c] >= 2.
        if m > 1 && n > 1 {
            if grid[0][1] > 1 && grid[1][0] > 1 {
                return -1;
            }
        }

        let mut dist = vec![vec![i32::MAX; n]; m];
        // Priority queue stores (time, row, col)
        // Using Reverse to make BinaryHeap act as a min-heap
        let mut pq = BinaryHeap::new();

        dist[0][0] = 0;
        pq.push(Reverse((0, 0, 0)));

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some(Reverse((time, r, c))) = pq.pop() {
            // If we found a shorter path to this cell already, skip
            if time > dist[r][c] {
                continue;
            }

            // If we reached the target cell, return the time
            if r == m - 1 && c == n - 1 {
                return time;
            }

            // Explore neighbors
            for i in 0..4 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                // Check bounds
                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    let new_arrival_time = time + 1;
                    let wait_time_required = grid[nr][nc];

                    let mut actual_entry_time;
                    if new_arrival_time >= wait_time_required {
                        // No wait needed, or already waited enough
                        actual_entry_time = new_arrival_time;
                    } else {
                        // new_arrival_time < wait_time_required, need to wait
                        let time_to_wait_at_cell = wait_time_required - new_arrival_time;
                        if time_to_wait_at_cell % 2 == 0 {
                            // If waiting an even number of units, enter at wait_time_required
                            actual_entry_time = wait_time_required;
                        } else {
                            // If waiting an odd number of units, need to spend one extra unit
                            // by moving back and forth, so enter at wait_time_required + 1
                            actual_entry_time = wait_time_required + 1;
                        }
                    }

                    // If this path is shorter, update distance and push to PQ
                    if actual_entry_time < dist[nr][nc] {
                        dist[nr][nc] = actual_entry_time;
                        pq.push(Reverse((actual_entry_time, nr, nc)));
                    }
                }
            }
        }

        // If the target cell is unreachable
        -1
    }
}