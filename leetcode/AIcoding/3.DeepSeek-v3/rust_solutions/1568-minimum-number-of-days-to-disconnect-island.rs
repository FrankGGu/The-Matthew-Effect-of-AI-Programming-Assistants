impl Solution {
    pub fn min_days(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if Self::count_islands(&grid) != 1 {
            return 0;
        }
        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    let mut new_grid = grid.clone();
                    new_grid[i][j] = 0;
                    if Self::count_islands(&new_grid) != 1 {
                        return 1;
                    }
                }
            }
        }
        2
    }

    fn count_islands(grid: &Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        let mut visited = vec![vec![false; cols]; rows];
        let mut count = 0;
        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 && !visited[i][j] {
                    count += 1;
                    Self::dfs(grid, &mut visited, i, j);
                }
            }
        }
        count
    }

    fn dfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize) {
        let rows = grid.len();
        let cols = grid[0].len();
        if i >= rows || j >= cols || grid[i][j] == 0 || visited[i][j] {
            return;
        }
        visited[i][j] = true;
        if i > 0 {
            Self::dfs(grid, visited, i - 1, j);
        }
        if j > 0 {
            Self::dfs(grid, visited, i, j - 1);
        }
        if i + 1 < rows {
            Self::dfs(grid, visited, i + 1, j);
        }
        if j + 1 < cols {
            Self::dfs(grid, visited, i, j + 1);
        }
    }
}