use std::collections::VecDeque;

impl Solution {
    pub fn min_cost(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dist = vec![vec![i32::MAX; n]; m];
        let mut queue = VecDeque::new();

        dist[0][0] = 0;
        queue.push_back((0, 0));

        let dx = [0, 0, 1, -1];
        let dy = [1, -1, 0, 0];

        while let Some((x, y)) = queue.pop_front() {
            for i in 0..4 {
                let nx = x as i32 + dx[i];
                let ny = y as i32 + dy[i];

                if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;

                    let cost = if grid[x][y] as usize == i + 1 { 0 } else { 1 };

                    if dist[x][y] + cost < dist[nx][ny] {
                        dist[nx][ny] = dist[x][y] + cost;
                        if cost == 0 {
                            queue.push_front((nx, ny));
                        } else {
                            queue.push_back((nx, ny));
                        }
                    }
                }
            }
        }

        dist[m - 1][n - 1]
    }
}