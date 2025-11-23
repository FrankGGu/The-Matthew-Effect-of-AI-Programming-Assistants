impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_days(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut island_count = 0;
        let mut island_coords = Vec::new();

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    island_count += 1;
                    if island_count > 1 {
                        return 0;
                    }
                    let mut queue = VecDeque::new();
                    queue.push_back((i, j));
                    let mut visited = HashSet::new();
                    visited.insert((i, j));
                    while let Some((x, y)) = queue.pop_front() {
                        island_coords.push((x, y));
                        for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                            let nx = x as i32 + dx;
                            let ny = y as i32 + dy;
                            if nx >= 0 && ny >= 0 && nx < m as i32 && ny < n as i32 {
                                let (nx, ny) = (nx as usize, ny as usize);
                                if grid[nx][ny] == 1 && !visited.contains(&(nx, ny)) {
                                    visited.insert((nx, ny));
                                    queue.push_back((nx, ny));
                                }
                            }
                        }
                    }
                }
            }
        }

        if island_count == 0 {
            return 0;
        }

        if island_coords.len() == 1 {
            return 1;
        }

        for &(x, y) in &island_coords {
            let mut new_grid = grid.clone();
            new_grid[x][y] = 0;
            let mut count = 0;
            let mut visited = HashSet::new();
            for i in 0..m {
                for j in 0..n {
                    if new_grid[i][j] == 1 && !visited.contains(&(i, j)) {
                        count += 1;
                        if count > 1 {
                            return 1;
                        }
                        let mut queue = VecDeque::new();
                        queue.push_back((i, j));
                        visited.insert((i, j));
                        while let Some((x, y)) = queue.pop_front() {
                            for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                                let nx = x as i32 + dx;
                                let ny = y as i32 + dy;
                                if nx >= 0 && ny >= 0 && nx < m as i32 && ny < n as i32 {
                                    let (nx, ny) = (nx as usize, ny as usize);
                                    if new_grid[nx][ny] == 1 && !visited.contains(&(nx, ny)) {
                                        visited.insert((nx, ny));
                                        queue.push_back((nx, ny));
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        2
    }
}
}