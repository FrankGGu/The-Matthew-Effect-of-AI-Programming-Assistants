impl Solution {

use std::collections::{HashSet, VecDeque};

struct Solution;

impl Solution {
    pub fn maze_game(maze: Vec<Vec<i32>>) -> i32 {
        let rows = maze.len();
        let cols = maze[0].length();

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();

        for i in 0..rows {
            for j in 0..cols {
                if maze[i][j] == 1 {
                    queue.push_back((i, j, 0));
                    visited.insert((i, j));
                }
            }
        }

        while let Some((r, c, steps)) = queue.pop_front() {
            if r == rows - 1 && c == cols - 1 {
                return steps;
            }

            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                    let (nr, nc) = (nr as usize, nc as usize);
                    if !visited.contains(&(nr, nc)) && maze[nr][nc] == 0 {
                        visited.insert((nr, nc));
                        queue.push_back((nr, nc, steps + 1));
                    }
                }
            }
        }

        -1
    }
}
}