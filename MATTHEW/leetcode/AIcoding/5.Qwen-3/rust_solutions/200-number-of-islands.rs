struct Solution;

impl Solution {
    pub fn num_islands(mut grid: Vec<Vec<char>>) -> i32 {
        if grid.is_empty() || grid[0].is_empty() {
            return 0;
        }

        let rows = grid.len();
        let cols = grid[0].len();
        let mut count = 0;

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == '1' {
                    Self::dfs(&mut grid, i, j, rows, cols);
                    count += 1;
                }
            }
        }

        count
    }

    fn dfs(grid: &mut Vec<Vec<char>>, i: usize, j: usize, rows: usize, cols: usize) {
        if i >= rows || j >= cols || grid[i][j] != '1' {
            return;
        }

        grid[i][j] = '0';

        Self::dfs(grid, i + 1, j, rows, cols);
        Self::dfs(grid, i - 1, j, rows, cols);
        Self::dfs(grid, i, j + 1, rows, cols);
        Self::dfs(grid, i, j - 1, rows, cols);
    }
}