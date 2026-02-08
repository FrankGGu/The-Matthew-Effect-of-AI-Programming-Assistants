impl Solution {
    pub fn minimum_obstacles(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dist = vec![vec![i32::MAX; n]; m];
        dist[0][0] = 0;
        let mut deque = std::collections::VecDeque::new();
        deque.push_back((0, 0));

        while let Some((x, y)) = deque.pop_front() {
            let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
            for (dx, dy) in directions {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;

                if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    let weight = grid[nx][ny];

                    if dist[x][y] + weight < dist[nx][ny] {
                        dist[nx][ny] = dist[x][y] + weight;
                        if weight == 0 {
                            deque.push_front((nx, ny));
                        } else {
                            deque.push_back((nx, ny));
                        }
                    }
                }
            }
        }

        dist[m - 1][n - 1]
    }
}