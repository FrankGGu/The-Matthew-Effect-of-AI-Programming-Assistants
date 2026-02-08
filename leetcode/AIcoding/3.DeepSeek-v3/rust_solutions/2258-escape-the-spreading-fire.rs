use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn maximum_minutes(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        let mut fire_time = vec![vec![-1; n]; m];
        let mut q = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    q.push_back((i, j));
                    fire_time[i][j] = 0;
                }
            }
        }

        let mut time = 0;
        while !q.is_empty() {
            time += 1;
            for _ in 0..q.len() {
                let (x, y) = q.pop_front().unwrap();
                for &(dx, dy) in &dirs {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;
                    if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                        let nx = nx as usize;
                        let ny = ny as usize;
                        if grid[nx][ny] == 0 && fire_time[nx][ny] == -1 {
                            fire_time[nx][ny] = time;
                            q.push_back((nx, ny));
                        }
                    }
                }
            }
        }

        let check = |wait: i32| -> bool {
            let mut q = VecDeque::new();
            let mut visited = HashSet::new();
            q.push_back((0, 0));
            visited.insert((0, 0));
            let mut time = 0;

            while !q.is_empty() {
                time += 1;
                for _ in 0..q.len() {
                    let (x, y) = q.pop_front().unwrap();
                    for &(dx, dy) in &dirs {
                        let nx = x as i32 + dx;
                        let ny = y as i32 + dy;
                        if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                            let nx = nx as usize;
                            let ny = ny as usize;
                            if nx == m - 1 && ny == n - 1 {
                                if fire_time[nx][ny] == -1 || time + wait <= fire_time[nx][ny] {
                                    return true;
                                }
                            }
                            if grid[nx][ny] == 0 && !visited.contains(&(nx, ny)) {
                                if fire_time[nx][ny] == -1 || time + wait < fire_time[nx][ny] {
                                    visited.insert((nx, ny));
                                    q.push_back((nx, ny));
                                }
                            }
                        }
                    }
                }
            }
            false
        };

        let mut left = 0;
        let mut right = m as i32 * n as i32;
        let mut ans = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            if check(mid) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        ans
    }
}