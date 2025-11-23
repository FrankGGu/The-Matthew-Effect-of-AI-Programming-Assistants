impl Solution {
    pub fn max_area_of_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut max_area = 0;
        let mut grid = grid;
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    let area = Self::dfs(&mut grid, i as i32, j as i32);
                    max_area = max_area.max(area);
                }
            }
        }

        max_area
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, i: i32, j: i32) -> i32 {
        if i < 0 || j < 0 || i >= grid.len() as i32 || j >= grid[0].len() as i32 || grid[i as usize][j as usize] != 1 {
            return 0;
        }

        grid[i as usize][j as usize] = 0;

        1 + Self::dfs(grid, i + 1, j) + Self::dfs(grid, i - 1, j) + Self::dfs(grid, i, j + 1) + Self::dfs(grid, i, j - 1)
    }
}