struct Solution;

impl Solution {
    pub fn closed_islands(mut grid: Vec<Vec<i32>>) -> i32 {
        if grid.is_empty() || grid[0].is_empty() {
            return 0;
        }

        let rows = grid.len();
        let cols = grid[0].len();

        // Mark all lands connected to the borders as visited
        for i in 0..rows {
            for j in 0..cols {
                if (i == 0 || i == rows - 1 || j == 0 || j == cols - 1) && grid[i][j] == 1 {
                    Self::dfs(&mut grid, i, j);
                }
            }
        }

        // Count the remaining closed islands
        let mut count = 0;
        for i in 1..rows - 1 {
            for j in 1..cols - 1 {
                if grid[i][j] == 1 {
                    count += 1;
                    Self::dfs(&mut grid, i, j);
                }
            }
        }

        count
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize) {
        if i < 0 || i >= grid.len() || j < 0 || j >= grid[0].len() || grid[i][j] != 1 {
            return;
        }

        grid[i][j] = 0;

        Self::dfs(grid, i + 1, j);
        Self::dfs(grid, i - 1, j);
        Self::dfs(grid, i, j + 1);
        Self::dfs(grid, i, j - 1);
    }
}