use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn largest_island(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut color = 2;
        let mut area = HashMap::new();
        let mut max_area = 0;

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    let mut current_area = 0;
                    Self::dfs(i, j, color, &mut current_area, &mut grid.clone(), n);
                    area.insert(color, current_area);
                    max_area = max_area.max(current_area);
                    color += 1;
                }
            }
        }

        let mut result = max_area;
        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 0 {
                    let mut colors = HashSet::new();
                    let mut current = 1;
                    for &(di, dj) in &[(-1, 0), (1, 0), (0, -1), (0, 1)] {
                        let ni = i as i32 + di;
                        let nj = j as i32 + dj;
                        if ni >= 0 && ni < n as i32 && nj >= 0 && nj < n as i32 {
                            let color_val = grid[ni as usize][nj as usize];
                            if color_val > 1 && !colors.contains(&color_val) {
                                colors.insert(color_val);
                                current += area.get(&color_val).unwrap_or(&0);
                            }
                        }
                    }
                    result = result.max(current);
                }
            }
        }

        result
    }

    fn dfs(i: usize, j: usize, color: i32, current_area: &mut i32, grid: &mut Vec<Vec<i32>>, n: usize) {
        if i >= n || j >= n || grid[i][j] != 1 {
            return;
        }
        grid[i][j] = color;
        *current_area += 1;
        if i > 0 {
            Self::dfs(i - 1, j, color, current_area, grid, n);
        }
        if i + 1 < n {
            Self::dfs(i + 1, j, color, current_area, grid, n);
        }
        if j > 0 {
            Self::dfs(i, j - 1, color, current_area, grid, n);
        }
        if j + 1 < n {
            Self::dfs(i, j + 1, color, current_area, grid, n);
        }
    }
}