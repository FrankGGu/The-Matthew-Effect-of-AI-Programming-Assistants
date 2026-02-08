use std::collections::VecDeque;

impl Solution {
    pub fn shortest_path_binary_matrix(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if n == 0 {
            return -1;
        }
        if grid[0][0] == 1 || grid[n - 1][n - 1] == 1 {
            return -1;
        }

        let mut queue: VecDeque<(usize, usize, i32)> = VecDeque::new();
        let mut visited: Vec<Vec<bool>> = vec![vec![false; n]; n];

        queue.push_back((0, 0, 1));
        visited[0][0] = true;

        let dr = [-1, -1, -1, 0, 0, 1, 1, 1];
        let dc = [-1, 0, 1, -1, 1, -1, 0, 1];

        while let Some((r, c, dist)) = queue.pop_front() {
            if r == n - 1 && c == n - 1 {
                return dist;
            }

            for i in 0..8 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                if nr >= 0
                    && nr < n as i32
                    && nc >= 0
                    && nc < n as i32
                {
                    let nr_usize = nr as usize;
                    let nc_usize = nc as usize;
                    if grid[nr_usize][nc_usize] == 0 && !visited[nr_usize][nc_usize] {
                        visited[nr_usize][nc_usize] = true;
                        queue.push_back((nr_usize, nc_usize, dist + 1));
                    }
                }
            }
        }

        -1
    }
}