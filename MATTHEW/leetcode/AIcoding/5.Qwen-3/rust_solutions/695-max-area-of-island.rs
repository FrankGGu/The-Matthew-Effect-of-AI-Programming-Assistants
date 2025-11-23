struct Solution;

impl Solution {
    pub fn max_area_of_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let mut max_area = 0;
        let rows = grid.len();
        let cols = if rows > 0 { grid[0].len() } else { 0 };

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    max_area = std::cmp::max(max_area, Self::dfs(&mut grid, i, j, rows, cols));
                }
            }
        }

        max_area
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize, rows: usize, cols: usize) -> i32 {
        if i >= rows || j >= cols || grid[i][j] != 1 {
            return 0;
        }

        grid[i][j] = 0;

        1 + Self::dfs(grid, i + 1, j, rows, cols) +
        Self::dfs(grid, i - 1, j, rows, cols) +
        Self::dfs(grid, i, j + 1, rows, cols) +
        Self::dfs(grid, i, j - 1, rows, cols)
    }
}