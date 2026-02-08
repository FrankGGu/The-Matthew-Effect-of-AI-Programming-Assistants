use std::collections::VecDeque;

impl Solution {
    pub fn find_safe_path(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dist = vec![vec![-1; n]; m];
        let mut q = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 0 {
                    dist[i][j] = 0;
                    q.push_back((i, j));
                }
            }
        }

        let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        while let Some((x, y)) = q.pop_front() {
            for &(dx, dy) in dirs.iter() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if dist[nx][ny] == -1 {
                        dist[nx][ny] = dist[x][y] + 1;
                        q.push_back((nx, ny));
                    }
                }
            }
        }

        let mut max_safe = vec![vec![0; n]; m];
        let mut q = VecDeque::new();
        if dist[0][0] > 0 {
            max_safe[0][0] = dist[0][0];
            q.push_back((0, 0));
        }

        let mut res = 0;
        while let Some((x, y)) = q.pop_front() {
            res = res.max(max_safe[x][y]);
            if x == m - 1 && y == n - 1 {
                break;
            }
            for &(dx, dy) in dirs.iter() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    let new_safe = max_safe[x][y].min(dist[nx][ny]);
                    if new_safe > max_safe[nx][ny] {
                        max_safe[nx][ny] = new_safe;
                        q.push_back((nx, ny));
                    }
                }
            }
        }

        res
    }
}