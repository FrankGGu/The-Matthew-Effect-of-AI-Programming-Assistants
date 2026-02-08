impl Solution {
    pub fn unique_paths_iii(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut start_row = 0;
        let mut start_col = 0;
        let mut empty_squares = 0;

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 0 {
                    empty_squares += 1;
                } else if grid[i][j] == 1 {
                    start_row = i;
                    start_col = j;
                }
            }
        }

        fn dfs(
            grid: &mut Vec<Vec<i32>>,
            row: usize,
            col: usize,
            empty_squares: i32,
        ) -> i32 {
            let m = grid.len();
            let n = grid[0].len();

            if row < 0 || row >= m || col < 0 || col >= n || grid[row][col] == -1 {
                return 0;
            }

            if grid[row][col] == 2 {
                if empty_squares == -1 {
                    return 1;
                } else {
                    return 0;
                }
            }

            grid[row][col] = -1;
            let mut count = 0;
            count += dfs(grid, row + 1, col, empty_squares - 1);
            count += dfs(grid, row - 1, col, empty_squares - 1);
            count += dfs(grid, row, col + 1, empty_squares - 1);
            count += dfs(grid, row, col - 1, empty_squares - 1);
            grid[row][col] = 0;

            count
        }

        let mut grid_copy = grid.clone();
        dfs(&mut grid_copy, start_row, start_col, empty_squares)
    }
}