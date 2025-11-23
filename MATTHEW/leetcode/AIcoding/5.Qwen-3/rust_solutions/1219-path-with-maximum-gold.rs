impl Solution {

use std::cmp::max;

impl Solution {
    pub fn get_maximum_gold(grid: Vec<Vec<i32>>) -> i32 {
        let mut max_gold = 0;
        let rows = grid.len();
        let cols = grid[0].len();

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] > 0 {
                    max_gold = max(max_gold, dfs(&grid, i, j, &mut vec![vec![false; cols]; rows]));
                }
            }
        }

        max_gold
    }
}

fn dfs(grid: &Vec<Vec<i32>>, i: usize, j: usize, visited: &mut Vec<Vec<bool>>) -> i32 {
    if i < 0 || i >= grid.len() || j < 0 || j >= grid[0].len() || grid[i][j] == 0 || visited[i][j] {
        return 0;
    }

    visited[i][j] = true;
    let current_gold = grid[i][j];

    let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
    let mut max_gold = 0;

    for &(dx, dy) in &directions {
        let ni = i as i32 + dx;
        let nj = j as i32 + dy;
        if ni >= 0 && ni < grid.len() as i32 && nj >= 0 && nj < grid[0].len() as i32 {
            max_gold = max(max_gold, dfs(grid, ni as usize, nj as usize, visited));
        }
    }

    visited[i][j] = false;
    current_gold + max_gold
}
}