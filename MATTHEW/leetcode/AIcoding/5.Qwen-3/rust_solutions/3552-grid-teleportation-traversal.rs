impl Solution {

use std::collections::{HashSet, VecDeque};

struct Solution;

impl Solution {
    pub fn bfs(grid: Vec<Vec<char>>, start: (i32, i32), end: (i32, i32)) -> i32 {
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((start.0, start.1, 0));
        visited.insert((start.0, start.1));

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some((x, y, steps)) = queue.pop_front() {
            if (x, y) == end {
                return steps;
            }

            for &(dx, dy) in &directions {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && ny >= 0 && nx < grid.len() as i32 && ny < grid[0].len() as i32 {
                    if !visited.contains(&(nx, ny)) {
                        visited.insert((nx, ny));
                        queue.push_back((nx, ny, steps + 1));
                    }
                }
            }

            if grid[x as usize][y as usize] == 'T' {
                for i in 0..grid.len() {
                    for j in 0..grid[0].len() {
                        if grid[i][j] == 'T' && (i as i32, j as i32) != (x, y) {
                            if !visited.contains(&(i as i32, j as i32)) {
                                visited.insert((i as i32, j as i32));
                                queue.push_back((i as i32, j as i32, steps + 1));
                            }
                        }
                    }
                }
            }
        }

        -1
    }
}
}