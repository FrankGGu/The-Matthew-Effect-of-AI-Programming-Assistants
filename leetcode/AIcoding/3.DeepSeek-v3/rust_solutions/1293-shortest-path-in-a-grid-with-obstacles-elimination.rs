use std::collections::VecDeque;

impl Solution {
    pub fn shortest_path(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        if m == 1 && n == 1 {
            return 0;
        }
        let k = k as usize;
        let mut visited = vec![vec![vec![false; k + 1]; n]; m];
        let mut queue = VecDeque::new();
        queue.push_back((0, 0, k, 0));
        visited[0][0][k] = true;

        let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some((i, j, remaining, steps)) = queue.pop_front() {
            for (di, dj) in dirs.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if ni == m - 1 && nj == n - 1 {
                        return steps + 1;
                    }
                    if grid[ni][nj] == 0 {
                        if !visited[ni][nj][remaining] {
                            visited[ni][nj][remaining] = true;
                            queue.push_back((ni, nj, remaining, steps + 1));
                        }
                    } else if remaining > 0 {
                        if !visited[ni][nj][remaining - 1] {
                            visited[ni][nj][remaining - 1] = true;
                            queue.push_back((ni, nj, remaining - 1, steps + 1));
                        }
                    }
                }
            }
        }

        -1
    }
}