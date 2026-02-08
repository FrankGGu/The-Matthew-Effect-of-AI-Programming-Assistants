use std::collections::VecDeque;

impl Solution {
    pub fn shortest_path_binary_matrix(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if grid[0][0] == 1 || grid[n - 1][n - 1] == 1 {
            return -1;
        }
        if n == 1 {
            return 1;
        }

        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 1));
        let mut visited = vec![vec![false; n]; n];
        visited[0][0] = true;
        let dirs = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];

        while let Some((i, j, dist)) = queue.pop_front() {
            for (di, dj) in dirs.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < n as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if ni == n - 1 && nj == n - 1 {
                        return dist + 1;
                    }
                    if grid[ni][nj] == 0 && !visited[ni][nj] {
                        visited[ni][nj] = true;
                        queue.push_back((ni, nj, dist + 1));
                    }
                }
            }
        }
        -1
    }
}