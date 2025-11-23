impl Solution {
    pub fn color_border(grid: Vec<Vec<i32>>, row: i32, col: i32, color: i32) -> Vec<Vec<i32>> {
        let mut grid = grid;
        let m = grid.len();
        let n = grid[0].len();
        let row = row as usize;
        let col = col as usize;
        let original_color = grid[row][col];
        let mut visited = vec![vec![false; n]; m];
        let mut borders = Vec::new();

        fn dfs(
            grid: &mut Vec<Vec<i32>>,
            row: usize,
            col: usize,
            original_color: i32,
            visited: &mut Vec<Vec<bool>>,
            borders: &mut Vec<(usize, usize)>,
        ) {
            let m = grid.len();
            let n = grid[0].len();

            if row < 0 || row >= m || col < 0 || col >= n || visited[row][col] || grid[row][col] != original_color {
                return;
            }

            visited[row][col] = true;

            let is_border = row == 0 || row == m - 1 || col == 0 || col == n - 1
                || grid[row - 1][col] != original_color
                || grid[row + 1][col] != original_color
                || grid[row][col - 1] != original_color
                || grid[row][col + 1] != original_color;

            if is_border {
                borders.push((row, col));
            }

            if row > 0 {
                dfs(grid, row - 1, col, original_color, visited, borders);
            }
            if row < m - 1 {
                dfs(grid, row + 1, col, original_color, visited, borders);
            }
            if col > 0 {
                dfs(grid, row, col - 1, original_color, visited, borders);
            }
            if col < n - 1 {
                dfs(grid, row, col + 1, original_color, visited, borders);
            }
        }

        dfs(&mut grid, row, col, original_color, &mut visited, &mut borders);

        for (r, c) in borders {
            grid[r][c] = color;
        }

        grid
    }
}