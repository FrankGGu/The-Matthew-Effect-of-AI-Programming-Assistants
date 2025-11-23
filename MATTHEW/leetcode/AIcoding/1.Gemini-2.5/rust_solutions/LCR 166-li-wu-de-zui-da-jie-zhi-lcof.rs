impl Solution {
    pub fn max_value(mut grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        if n == 0 {
            return 0;
        }

        // Fill the first row
        for j in 1..n {
            grid[0][j] += grid[0][j - 1];
        }

        // Fill the first column
        for i in 1..m {
            grid[i][0] += grid[i - 1][0];
        }

        // Fill the rest of the grid
        for i in 1..m {
            for j in 1..n {
                grid[i][j] += grid[i - 1][j].max(grid[i][j - 1]);
            }
        }

        grid[m - 1][n - 1]
    }
}