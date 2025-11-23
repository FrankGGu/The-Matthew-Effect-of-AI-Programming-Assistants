use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn swim_in_rising_water(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if n == 0 {
            return 0;
        }

        let mut dist = vec![vec![i32::MAX; n]; n];
        let mut pq = BinaryHeap::new();

        // The priority queue stores (max_height_encountered, row, col)
        // We use Reverse to make BinaryHeap act as a min-priority queue
        pq.push(Reverse((grid[0][0], 0, 0)));
        dist[0][0] = grid[0][0];

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some(Reverse((current_max_height, r, c))) = pq.pop() {
            if r == n - 1 && c == n - 1 {
                return current_max_height;
            }

            if current_max_height > dist[r][c] {
                continue;
            }

            for i in 0..4 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                if nr >= 0 && nr < n as i32 && nc >= 0 && nc < n as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    let new_max_height = current_max_height.max(grid[nr][nc]);

                    if new_max_height < dist[nr][nc] {
                        dist[nr][nc] = new_max_height;
                        pq.push(Reverse((new_max_height, nr, nc)));
                    }
                }
            }
        }

        unreachable!()
    }
}