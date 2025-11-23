impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn can_cut_grid(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        let mut visited = vec![vec![false; n]; m];

        for i in 0..m {
            for j in 0..n {
                if !visited[i][j] {
                    let mut regions = HashSet::new();
                    Self::dfs(&grid, &mut visited, i, j, &mut regions);

                    if regions.len() < 2 {
                        return false;
                    }
                }
            }
        }

        true
    }

    fn dfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize, regions: &mut HashSet<(usize, usize)>) {
        if i >= grid.len() || j >= grid[0].len() || visited[i][j] {
            return;
        }

        visited[i][j] = true;
        regions.insert((i, j));

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        for (dx, dy) in directions {
            let ni = i as isize + dx;
            let nj = j as isize + dy;

            if ni >= 0 && ni < grid.len() as isize && nj >= 0 && nj < grid[0].len() as isize {
                let ni = ni as usize;
                let nj = nj as usize;

                if !visited[ni][nj] && grid[ni][nj] == grid[i][j] {
                    Self::dfs(grid, visited, ni, nj, regions);
                }
            }
        }
    }
}
}