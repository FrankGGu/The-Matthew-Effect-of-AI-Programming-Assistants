impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn capture_forts(forts: Vec<Vec<i32>>) -> i32 {
        let rows = forts.len();
        let cols = forts[0].len();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();

        for i in 0..rows {
            for j in 0..cols {
                if forts[i][j] == 1 {
                    queue.push_back((i, j));
                    visited.insert((i, j));
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut result = 0;

        while let Some((x, y)) = queue.pop_front() {
            for &(dx, dy) in &directions {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;

                if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                    let (nx, ny) = (nx as usize, ny as usize);
                    if !visited.contains(&(nx, ny)) {
                        if forts[nx][ny] == -1 {
                            result += 1;
                        } else if forts[nx][ny] == 0 {
                            visited.insert((nx, ny));
                            queue.push_back((nx, ny));
                        }
                    }
                }
            }
        }

        result
    }
}
}