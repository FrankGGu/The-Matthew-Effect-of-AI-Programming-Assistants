impl Solution {
    pub fn num_enclaves(mut grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        if n == 0 {
            return 0;
        }

        fn dfs(grid: &mut Vec<Vec<i32>>, r: usize, c: usize, m: usize, n: usize) {
            if r >= m || c >= n || grid[r][c] == 0 {
                return;
            }

            grid[r][c] = 0;

            if r > 0 {
                dfs(grid, r - 1, c, m, n);
            }
            if r + 1 < m {
                dfs(grid, r + 1, c, m, n);
            }
            if c > 0 {
                dfs(grid, r, c - 1, m, n);
            }
            if c + 1 < n {
                dfs(grid, r, c + 1, m, n);
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

        for i in 1..m - 1 {
            if grid[i][0] == 1 {
                dfs(&mut grid, i, 0, m, n);
            }
            if grid[i][n - 1] == 1 {
                dfs(&mut grid, i, n - 1, m, n);
            }
        }

        let mut enclaves_count = 0;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    enclaves_count += 1;
                }
            }
        }

        enclaves_count
    }
}