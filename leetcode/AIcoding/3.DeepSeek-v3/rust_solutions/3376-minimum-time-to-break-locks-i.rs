impl Solution {
    pub fn minimum_time_to_break_locks(grid: Vec<Vec<i32>>) -> i32 {
        use std::collections::VecDeque;

        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        if n == 0 {
            return 0;
        }

        let mut visited = vec![vec![false; n]; m];
        let mut queue = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 0 {
                    queue.push_back((i, j, 0));
                    visited[i][j] = true;
                }
            }
        }

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut max_time = 0;

        while let Some((i, j, time)) = queue.pop_front() {
            max_time = max_time.max(time);

            for (di, dj) in dirs.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;

                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;

                    if !visited[ni][nj] && grid[ni][nj] == 1 {
                        visited[ni][nj] = true;
                        queue.push_back((ni, nj, time + 1));
                    }
                }
            }
        }

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 && !visited[i][j] {
                    return -1;
                }
            }
        }

        max_time
    }
}