use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_time(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        if m == 1 && n == 1 {
            return 0;
        }

        // Special impossible condition for this problem:
        // If we cannot move from (0,0) to any adjacent cell (0,1) or (1,0) at time 1.
        // We start at time 0. Moving to a neighbor takes 1 unit of time, so we arrive at time 1.
        // If grid[neighbor_cell] > 1, we cannot enter that cell at time 1.
        // If all possible first moves are blocked, it's impossible.
        let mut can_move_from_start = false;
        if m > 1 && grid[1][0] <= 1 {
            can_move_from_start = true;
        }
        if n > 1 && grid[0][1] <= 1 {
            can_move_from_start = true;
        }
        if !can_move_from_start {
            return -1;
        }

        let mut dist: Vec<Vec<i32>> = vec![vec![i32::MAX; n]; m];
        let mut pq: BinaryHeap<Reverse<(i32, usize, usize)>> = BinaryHeap::new();

        // Start at (0,0) at time 0. grid[0][0] is guaranteed to be 0.
        dist[0][0] = 0;
        pq.push(Reverse((0, 0, 0)));

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some(Reverse((current_time, r, c))) = pq.pop() {
            if current_time > dist[r][c] {
                continue;
            }

            if r == m - 1 && c == n - 1 {
                return current_time;
            }

            for i in 0..4 {
                let nr = r as isize + dr[i];
                let nc = c as isize + dc[i];

                if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    let arrival_time = current_time + 1;
                    // We must wait until at least grid[nr][nc] to enter.
                    // So the earliest we can enter is max(arrival_time, grid[nr][nc]).
                    let next_available_time = arrival_time.max(grid[nr][nc]);

                    if next_available_time < dist[nr][nc] {
                        dist[nr][nc] = next_available_time;
                        pq.push(Reverse((next_available_time, nr, nc)));
                    }
                }
            }
        }

        // If the target (m-1, n-1) is unreachable
        -1
    }
}