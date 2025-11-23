impl Solution {
    pub fn closed_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        let mut count = 0;

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 0 {
                    if Self::dfs(&mut grid, i as i32, j as i32, rows as i32, cols as i32) {
                        count += 1;
                    }
                }
            }
        }
        count
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, i: i32, j: i32, rows: i32, cols: i32) -> bool {
        if i < 0 || i >= rows || j < 0 || j >= cols {
            return false;
        }
        if grid[i as usize][j as usize] == 1 {
            return true;
        }
        grid[i as usize][j as usize] = 1;
        let top = Self::dfs(grid, i - 1, j, rows, cols);
        let bottom = Self::dfs(grid, i + 1, j, rows, cols);
        let left = Self::dfs(grid, i, j - 1, rows, cols);
        let right = Self::dfs(grid, i, j + 1, rows, cols);
        top && bottom && left && right
    }
}