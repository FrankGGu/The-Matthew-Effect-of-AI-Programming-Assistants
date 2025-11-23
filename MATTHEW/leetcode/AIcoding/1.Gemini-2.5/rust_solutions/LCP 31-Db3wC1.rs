use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn transforming_maze(maze: Vec<Vec<i32>>, start: (i32, i32), end: (i32, i32)) -> i32 {
        let rows = maze.len() as i32;
        let cols = maze[0].len() as i32;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        let mut queue: VecDeque<(i32, i32, i32)> = VecDeque::new();
        let mut visited: HashSet<(i32, i32, i32)> = HashSet::new();

        queue.push_back((start.0, start.1, 0));
        visited.insert((start.0, start.1, 0));

        while let Some((r, c, time)) = queue.pop_front() {
            if r == end.0 && c == end.1 {
                return time;
            }

            for i in 0..4 {
                let nr = r + dr[i];
                let nc = c + dc[i];
                let next_time = time + 1;

                if nr < 0 || nr >= rows || nc < 0 || nc >= cols {
                    continue;
                }

                let cell_type = maze[nr as usize][nc as usize];

                let is_blocked = match cell_type {
                    0 => false, // Empty cell, always open
                    1 => true,  // Wall, always blocked
                    2 => next_time % 2 != 0, // Transforming cell: blocked if next_time is odd
                    _ => true,  // Unknown type, treat as blocked
                };

                if is_blocked {
                    continue;
                }

                if visited.insert((nr, nc, next_time)) {
                    queue.push_back((nr, nc, next_time));
                }
            }
        }

        -1
    }
}