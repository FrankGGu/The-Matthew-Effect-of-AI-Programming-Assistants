use std::collections::BinaryHeap;

impl Solution {
    pub fn swim_in_water(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut min_heap = BinaryHeap::new();
        let mut visited = vec![vec![false; n]; n];
        let directions = vec![(1, 0), (0, 1), (-1, 0), (0, -1)];

        min_heap.push((grid[0][0], 0, 0));
        visited[0][0] = true;

        while let Some((time, x, y)) = min_heap.pop() {
            if x == n - 1 && y == n - 1 {
                return time;
            }
            for (dx, dy) in &directions {
                let nx = (x as isize + dx) as usize;
                let ny = (y as isize + dy) as usize;
                if nx < n && ny < n && !visited[nx][ny] {
                    visited[nx][ny] = true;
                    min_heap.push((time.max(grid[nx][ny]), nx, ny));
                }
            }
        }
        0
    }
}