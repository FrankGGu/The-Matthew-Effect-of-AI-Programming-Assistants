use std::collections::VecDeque;

impl Solution {
    pub fn maximum_minutes(forest: Vec<Vec<i32>>) -> i32 {
        let m = forest.len();
        let n = forest[0].len();

        fn bfs(forest: &Vec<Vec<i32>>, start_time: i32) -> i32 {
            let m = forest.len();
            let n = forest[0].len();

            let mut fire_grid = forest.clone();
            let mut person_grid = forest.clone();

            let mut fire_queue = VecDeque::new();
            for i in 0..m {
                for j in 0..n {
                    if forest[i][j] == 1 {
                        fire_queue.push_back((i, j, 0));
                    }
                }
            }

            let mut person_queue = VecDeque::new();
            person_queue.push_back((0, 0, start_time));

            let mut fire_visited = vec![vec![false; n]; m];
            let mut person_visited = vec![vec![false; n]; m];

            while let Some((row, col, time)) = fire_queue.pop_front() {
                if row < 0 || row >= m || col < 0 || col >= n || fire_visited[row][col] {
                    continue;
                }
                fire_visited[row][col] = true;
                fire_grid[row][col] = time;

                let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
                for (dr, dc) in directions {
                    let new_row = row as i32 + dr;
                    let new_col = col as i32 + dc;
                    if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                        let nr = new_row as usize;
                        let nc = new_col as usize;
                        if forest[nr][nc] == 0 {
                            fire_queue.push_back((nr, nc, time + 1));
                        }
                    }
                }
            }

            while let Some((row, col, time)) = person_queue.pop_front() {
                if row < 0 || row >= m || col < 0 || col >= n || person_visited[row][col] {
                    continue;
                }
                person_visited[row][col] = true;

                if time >= fire_grid[row][col] {
                    continue;
                }

                if row == m - 1 && col == n - 1 {
                    return 1;
                }

                let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
                for (dr, dc) in directions {
                    let new_row = row as i32 + dr;
                    let new_col = col as i32 + dc;
                    if new_row >= 0 && new_row < m as i32 && new_col >= 0 && new_col < n as i32 {
                        let nr = new_row as usize;
                        let nc = new_col as usize;
                        if forest[nr][nc] == 0 {
                            person_queue.push_back((nr, nc, time + 1));
                        }
                    }
                }
            }

            -1
        }

        if forest[0][0] == 1 {
            return -1;
        }
        let res = bfs(&forest, 0);
        if res == 1 {
            let mut left = 0;
            let mut right = 1000000000;
            let mut ans = -1;

            while left <= right {
                let mid = left + (right - left) / 2;
                if bfs(&forest, mid) == 1 {
                    ans = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            return ans;
        } else {
            return -1;
        }
    }
}