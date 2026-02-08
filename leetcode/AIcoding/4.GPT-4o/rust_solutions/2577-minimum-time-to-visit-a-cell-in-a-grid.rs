use std::collections::BinaryHeap;

pub struct Solution;

impl Solution {
    pub fn minimum_time(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut dist = vec![vec![i32::MAX; cols]; rows];
        let mut heap = BinaryHeap::new();

        dist[0][0] = 0;
        heap.push((0, 0, 0)); // (time, row, col)

        while let Some((time, r, c)) = heap.pop() {
            let time = -time; // Convert back to positive time
            if r == rows - 1 && c == cols - 1 {
                return time;
            }
            if time > dist[r][c] {
                continue;
            }
            for (dr, dc) in [(0, 1), (1, 0), (0, -1), (-1, 0)] {
                let nr = r as isize + dr;
                let nc = c as isize + dc;
                if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                    let wait_time = grid[nr as usize][nc as usize];
                    let next_time = time + 1 + if time % 2 == wait_time % 2 { 0 } else { 1 };
                    if next_time < dist[nr as usize][nc as usize] {
                        dist[nr as usize][nc as usize] = next_time;
                        heap.push((-next_time, nr as usize, nc as usize));
                    }
                }
            }
        }
        -1
    }
}