use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn nearest_exit(maze: Vec<Vec<char>>, entrance: Vec<i32>) -> i32 {
        let m = maze.len();
        let n = maze[0].len();

        let entrance_r = entrance[0] as usize;
        let entrance_c = entrance[1] as usize;

        let mut queue: VecDeque<(usize, usize, i32)> = VecDeque::new();
        let mut visited: Vec<Vec<bool>> = vec![vec![false; n]; m];

        queue.push_back((entrance_r, entrance_c, 0));
        visited[entrance_r][entrance_c] = true;

        let directions: [(isize, isize); 4] = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((r, c, steps)) = queue.pop_front() {
            if steps > 0 && (r == 0 || r == m - 1 || c == 0 || c == n - 1) {
                return steps;
            }

            for &(dr, dc) in &directions {
                let nr = r as isize + dr;
                let nc = c as isize + dc;

                if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                    let nr = nr as usize;
                    let nc = nc as usize;

                    if maze[nr][nc] == '.' && !visited[nr][nc] {
                        visited[nr][nc] = true;
                        queue.push_back((nr, nc, steps + 1));
                    }
                }
            }
        }

        -1
    }
}