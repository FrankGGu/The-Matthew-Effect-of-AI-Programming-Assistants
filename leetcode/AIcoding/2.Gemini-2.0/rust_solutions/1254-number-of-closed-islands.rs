impl Solution {
    pub fn closed_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let m = grid.len();
        let n = grid[0].len();

        for i in 0..m {
            if grid[i][0] == 0 {
                Self::dfs(&mut grid, i, 0);
            }
            if grid[i][n - 1] == 0 {
                Self::dfs(&mut grid, i, n - 1);
            }
        }

        for j in 0..n {
            if grid[0][j] == 0 {
                Self::dfs(&mut grid, 0, j);
            }
            if grid[m - 1][j] == 0 {
                Self::dfs(&mut grid, m - 1, j);
            }
        }

        let mut count = 0;
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 0 {
                    Self::dfs(&mut grid, i, j);
                    count += 1;
                }
            }
        }

        count
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize) {
        let m = grid.len();
        let n = grid[0].len();

        if i < 0 || i >= m || j < 0 || j >= n || grid[i][j] == 1 {
            return;
        }

        grid[i][j] = 1;
        Self::dfs(grid, i + 1, j);
        Self::dfs(grid, i - 1, j);
        Self::dfs(grid, i, j + 1);
        Self::dfs(grid, i, j - 1);
    }
}

struct Solution;