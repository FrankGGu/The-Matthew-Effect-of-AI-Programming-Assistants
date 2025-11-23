use std::collections::VecDeque;

impl Solution {
    pub fn maximum_safeness_factor(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut dist = vec![vec![i32::MAX; n]; n];
        let mut queue = VecDeque::new();

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    dist[i][j] = 0;
                    queue.push_back((i, j));
                }
            }
        }

        let dirs = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((x, y)) = queue.pop_front() {
            for (dx, dy) in dirs {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;

                if nx >= 0 && nx < n as i32 && ny >= 0 && ny < n as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;

                    if dist[nx][ny] == i32::MAX {
                        dist[nx][ny] = dist[x][y] + 1;
                        queue.push_back((nx, ny));
                    }
                }
            }
        }

        let mut left = 0;
        let mut right = 2 * n as i32;
        let mut ans = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut visited = vec![vec![false; n]; n];
            let mut q = VecDeque::new();

            if dist[0][0] >= mid {
                q.push_back((0, 0));
                visited[0][0] = true;
            }

            let mut found = false;

            while let Some((x, y)) = q.pop_front() {
                if x == n - 1 && y == n - 1 {
                    found = true;
                    break;
                }

                for (dx, dy) in dirs {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;

                    if nx >= 0 && nx < n as i32 && ny >= 0 && ny < n as i32 {
                        let nx = nx as usize;
                        let ny = ny as usize;

                        if !visited[nx][ny] && dist[nx][ny] >= mid {
                            visited[nx][ny] = true;
                            q.push_back((nx, ny));
                        }
                    }
                }
            }

            if found {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        ans
    }
}