use std::collections::VecDeque;

impl Solution {
    pub fn min_cost(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)];
        let mut cost = vec![vec![std::i32::MAX; n]; m];
        let mut q = VecDeque::new();
        cost[0][0] = 0;
        q.push_back((0, 0));

        while let Some((x, y)) = q.pop_front() {
            for (i, &(dx, dy)) in dirs.iter().enumerate() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    let new_cost = cost[x][y] + if grid[x][y] == (i + 1) as i32 { 0 } else { 1 };
                    if new_cost < cost[nx][ny] {
                        cost[nx][ny] = new_cost;
                        if grid[x][y] == (i + 1) as i32 {
                            q.push_front((nx, ny));
                        } else {
                            q.push_back((nx, ny));
                        }
                    }
                }
            }
        }
        cost[m - 1][n - 1]
    }
}