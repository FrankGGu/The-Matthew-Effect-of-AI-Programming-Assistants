use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_effort_path(heights: Vec<Vec<i32>>) -> i32 {
        let m = heights.len();
        let n = heights[0].len();

        let mut dist: Vec<Vec<i32>> = vec![vec![i32::MAX; n]; m];
        dist[0][0] = 0;

        let mut pq: BinaryHeap<Reverse<(i32, usize, usize)>> = BinaryHeap::new();
        pq.push(Reverse((0, 0, 0))); // (effort, row, col)

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        while let Some(Reverse((current_effort, r, c))) = pq.pop() {
            if current_effort > dist[r][c] {
                continue;
            }

            if r == m - 1 && c == n - 1 {
                return current_effort;
            }

            for i in 0..4 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    let effort_diff = (heights[r][c] - heights[nr][nc]).abs();
                    let new_effort = current_effort.max(effort_diff);

                    if new_effort < dist[nr][nc] {
                        dist[nr][nc] = new_effort;
                        pq.push(Reverse((new_effort, nr, nc)));
                    }
                }
            }
        }

        dist[m - 1][n - 1]
    }
}