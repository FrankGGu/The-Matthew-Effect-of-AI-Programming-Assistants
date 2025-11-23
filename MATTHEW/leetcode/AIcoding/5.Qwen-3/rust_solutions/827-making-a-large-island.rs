impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn largest_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let mut id = 2;
        let mut area = HashMap::new();

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 1 {
                    let size = Self::dfs(&mut grid, i, j, id);
                    area.insert(id, size);
                    id += 1;
                }
            }
        }

        let mut max_area = 0;
        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 0 {
                    let mut total = 1;
                    let mut seen = HashMap::new();
                    for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                        let x = i as i32 + dx;
                        let y = j as i32 + dy;
                        if x >= 0 && x < grid.len() as i32 && y >= 0 && y < grid[0].len() as i32 {
                            let neighbor_id = grid[x as usize][y as usize];
                            if neighbor_id > 1 && !seen.contains_key(&neighbor_id) {
                                total += area.get(&neighbor_id).unwrap_or(&0);
                                seen.insert(neighbor_id, ());
                            }
                        }
                    }
                    max_area = std::cmp::max(max_area, total);
                } else {
                    max_area = std::cmp::max(max_area, *area.get(&grid[i][j]).unwrap_or(&0));
                }
            }
        }

        max_area
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize, id: i32) -> i32 {
        if i >= grid.len() || j >= grid[0].len() || grid[i][j] != 1 {
            return 0;
        }

        grid[i][j] = id;
        let mut size = 1;
        for (dx, dy) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
            let x = i as i32 + dx;
            let y = j as i32 + dy;
            if x >= 0 && x < grid.len() as i32 && y >= 0 && y < grid[0].len() as i32 {
                size += Self::dfs(grid, x as usize, y as usize, id);
            }
        }

        size
    }
}
}