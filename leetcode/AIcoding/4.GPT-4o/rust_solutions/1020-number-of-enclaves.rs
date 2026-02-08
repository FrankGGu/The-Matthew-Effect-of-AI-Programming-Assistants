impl Solution {
    pub fn num_enclaves(grid: Vec<Vec<i32>>) -> i32 {
        let (m, n) = (grid.len(), grid[0].len());
        let mut grid = grid;

        fn dfs(x: usize, y: usize, grid: &mut Vec<Vec<i32>>) {
            if x >= grid.len() || y >= grid[0].len() || grid[x][y] == 0 {
                return;
            }
            grid[x][y] = 0;
            dfs(x + 1, y, grid);
            dfs(x - 1, y, grid);
            dfs(x, y + 1, grid);
            dfs(x, y - 1, grid);
        }

        for i in 0..m {
            for j in 0..n {
                if (i == 0 || i == m - 1 || j == 0 || j == n - 1) && grid[i][j] == 1 {
                    dfs(i, j, &mut grid);
                }
            }
        }

        grid.iter().flat_map(|row| row.iter()).filter(|&&cell| cell == 1).count() as i32
    }
}