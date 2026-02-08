use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_obstacles(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dist = vec![vec![i32::MAX; n]; m];
        dist[0][0] = 0;

        let mut heap = BinaryHeap::new();
        heap.push((0, 0, 0)); // (obstacles, x, y)

        while let Some((obstacles, x, y)) = heap.pop() {
            let obstacles = -obstacles;

            if x == m - 1 && y == n - 1 {
                return obstacles;
            }

            if obstacles > dist[x][y] {
                continue;
            }

            for (dx, dy) in &[(1, 0), (0, 1), (-1, 0), (0, -1)] {
                let nx = (x as isize + dx) as usize;
                let ny = (y as isize + dy) as usize;

                if nx < m && ny < n {
                    let new_obstacles = obstacles + grid[nx][ny];
                    if new_obstacles < dist[nx][ny] {
                        dist[nx][ny] = new_obstacles;
                        heap.push((-new_obstacles, nx, ny));
                    }
                }
            }
        }

        0
    }
}