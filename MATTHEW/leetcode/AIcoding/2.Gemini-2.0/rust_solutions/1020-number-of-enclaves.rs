impl Solution {
    pub fn num_enclaves(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let m = grid.len();
        let n = grid[0].len();

        fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize, m: usize, n: usize) {
            if i < 0 || i >= m || j < 0 || j >= n || grid[i][j] == 0 {
                return;
            }

            grid[i][j] = 0;
            dfs(grid, i + 1, j, m, n);
            dfs(grid, i - 1, j, m, n);
            dfs(grid, i, j + 1, m, n);
            dfs(grid, i, j - 1, m, n);
        }

        for i in 0..m {
            if grid[i][0] == 1 {
                dfs(&mut grid, i, 0, m, n);
            }
            if grid[i][n - 1] == 1 {
                dfs(&mut grid, i, n - 1, m, n);
            }
        }

        for j in 0..n {
            if grid[0][j] == 1 {
                dfs(&mut grid, 0, j, m, n);
            }
            if grid[m - 1][j] == 1 {
                dfs(&mut grid, m - 1, j, m, n);
            }
        }

        let mut count = 0;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    count += 1;
                }
            }
        }

        count
    }
}