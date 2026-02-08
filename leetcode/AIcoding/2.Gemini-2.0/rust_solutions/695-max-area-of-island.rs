impl Solution {
    pub fn max_area_of_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let mut max_area = 0;
        let rows = grid.len();
        let cols = if rows > 0 { grid[0].len() } else { 0 };

        fn dfs(grid: &mut Vec<Vec<i32>>, row: usize, col: usize) -> i32 {
            if row < 0 || row >= grid.len() || col < 0 || col >= grid[0].len() || grid[row][col] == 0 {
                return 0;
            }

            grid[row][col] = 0;
            let mut area = 1;
            area += dfs(grid, row + 1, col);
            area += dfs(grid, row - 1, col);
            area += dfs(grid, row, col + 1);
            area += dfs(grid, row, col - 1);
            area
        }

        for row in 0..rows {
            for col in 0..cols {
                if grid[row][col] == 1 {
                    max_area = max_area.max(dfs(&mut grid, row, col));
                }
            }
        }

        max_area
    }
}