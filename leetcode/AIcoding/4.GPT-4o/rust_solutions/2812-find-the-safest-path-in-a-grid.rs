use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_safeness(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut dist = vec![vec![-1; n]; n];
        let mut max_safeness = 0;

        let mut queue = BinaryHeap::new();
        queue.push((0, 0, 0)); // (safeness, x, y)

        while let Some((safeness, x, y)) = queue.pop() {
            let safeness = -safeness;
            if dist[x][y] >= safeness {
                continue;
            }
            dist[x][y] = safeness;

            if x == n - 1 && y == n - 1 {
                max_safeness = safeness;
                break;
            }

            for (dx, dy) in &[(1, 0), (0, 1), (-1, 0), (0, -1)] {
                let nx = (x as i32 + dx) as usize;
                let ny = (y as i32 + dy) as usize;
                if nx < n && ny < n {
                    queue.push((-safeness - 1, nx, ny));
                }
            }
        }

        max_safeness
    }
}