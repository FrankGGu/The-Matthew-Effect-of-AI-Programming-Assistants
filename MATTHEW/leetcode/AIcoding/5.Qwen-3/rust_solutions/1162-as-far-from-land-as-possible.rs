impl Solution {

use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn max_distance(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    queue.push_back((i, j));
                    visited.insert((i, j));
                }
            }
        }

        if queue.len() == 0 || queue.len() == n * n {
            return -1;
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let mut distance = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let (x, y) = queue.pop_front().unwrap();
                for &(dx, dy) in &directions {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;
                    if nx >= 0 && nx < n as i32 && ny >= 0 && ny < n as i32 {
                        let pos = (nx as usize, ny as usize);
                        if !visited.contains(&pos) {
                            visited.insert(pos);
                            queue.push_back(pos);
                        }
                    }
                }
            }
            distance += 1;
        }

        distance - 1
    }
}
}