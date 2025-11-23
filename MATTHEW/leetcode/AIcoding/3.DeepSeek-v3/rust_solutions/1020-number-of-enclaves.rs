impl Solution {
    pub fn num_enclaves(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let m = grid.len();
        let n = grid[0].len();

        for i in 0..m {
            Self::dfs(&mut grid, i, 0);
            Self::dfs(&mut grid, i, n - 1);
        }

        for j in 0..n {
            Self::dfs(&mut grid, 0, j);
            Self::dfs(&mut grid, m - 1, j);
        }

        grid.iter().map(|row| row.iter().sum::<i32>()).sum()
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize) {
        let m = grid.len();
        let n = grid[0].len();

        if i >= m || j >= n || grid[i][j] == 0 {
            return;
        }

        grid[i][j] = 0;

        if i > 0 {
            Self::dfs(grid, i - 1, j);
        }
        if i + 1 < m {
            Self::dfs(grid, i + 1, j);
        }
        if j > 0 {
            Self::dfs(grid, i, j - 1);
        }
        if j + 1 < n {
            Self::dfs(grid, i, j + 1);
        }
    }
}