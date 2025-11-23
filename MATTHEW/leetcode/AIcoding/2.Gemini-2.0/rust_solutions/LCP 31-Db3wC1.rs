use std::collections::VecDeque;

impl Solution {
    pub fn solve(maze: Vec<String>, start: Vec<i32>, destination: Vec<i32>) -> bool {
        let m = maze.len();
        let n = maze[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut queue = VecDeque::new();
        queue.push_back((start[0] as usize, start[1] as usize));
        visited[start[0] as usize][start[1] as usize] = true;

        let dx = [0, 0, 1, -1];
        let dy = [1, -1, 0, 0];

        while let Some((x, y)) = queue.pop_front() {
            if x == destination[0] as usize && y == destination[1] as usize {
                return true;
            }

            for i in 0..4 {
                let mut nx = x as i32;
                let mut ny = y as i32;

                while nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 && maze[nx as usize].as_bytes()[ny as usize] as char == '.' {
                    nx += dx[i];
                    ny += dy[i];
                }

                nx -= dx[i];
                ny -= dy[i];

                if !visited[nx as usize][ny as usize] {
                    visited[nx as usize][ny as usize] = true;
                    queue.push_back((nx as usize, ny as usize));
                }
            }
        }

        false
    }
}

struct Solution;