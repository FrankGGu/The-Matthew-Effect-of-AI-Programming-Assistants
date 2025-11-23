impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn max_fish(grid: Vec<Vec<i32>>) -> i32 {
        let mut visited = vec![vec![false; grid[0].len()]; grid.len()];
        let mut max_fish = 0;

        for i in 0..grid.len() {
            for j in 0..grid[i].len() {
                if !visited[i][j] && grid[i][j] > 0 {
                    let fish = dfs(&grid, &mut visited, i, j);
                    max_fish = max_fish.max(fish);
                }
            }
        }

        max_fish
    }
}

fn dfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize) -> i32 {
    if i >= grid.len() || j >= grid[i].len() || visited[i][j] || grid[i][j] == 0 {
        return 0;
    }

    visited[i][j] = true;
    let mut total = grid[i][j];

    let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

    for (dx, dy) in directions.iter() {
        let ni = i.wrapping_add(*dx as usize);
        let nj = j.wrapping_add(*dy as usize);
        total += dfs(grid, visited, ni, nj);
    }

    total
}
}