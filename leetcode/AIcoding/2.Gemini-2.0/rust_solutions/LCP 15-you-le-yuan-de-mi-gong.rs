use std::collections::VecDeque;

impl Solution {
    pub fn has_path(maze: Vec<Vec<i32>>, start: Vec<i32>, destination: Vec<i32>) -> bool {
        let m = maze.len();
        let n = maze[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut queue = VecDeque::new();
        queue.push_back(start);
        visited[start[0] as usize][start[1] as usize] = true;

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some(curr) = queue.pop_front() {
            if curr[0] == destination[0] && curr[1] == destination[1] {
                return true;
            }

            for (dx, dy) in directions {
                let mut x = curr[0] as i32;
                let mut y = curr[1] as i32;

                while x >= 0 && x < m as i32 && y >= 0 && y < n as i32 && maze[x as usize][y as usize] == 0 {
                    x += dx;
                    y += dy;
                }

                x -= dx;
                y -= dy;

                if !visited[x as usize][y as usize] {
                    visited[x as usize][y as usize] = true;
                    queue.push_back(vec![x, y]);
                }
            }
        }

        false
    }
}