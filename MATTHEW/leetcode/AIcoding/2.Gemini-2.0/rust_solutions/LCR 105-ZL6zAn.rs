impl Solution {
    pub fn max_area_of_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let mut max_area = 0;
        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 1 {
                    max_area = max_area.max(Self::dfs(&mut grid, i, j));
                }
            }
        }
        max_area
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize) -> i32 {
        if i >= grid.len() || j >= grid[0].len() || grid[i][j] == 0 {
            return 0;
        }

        grid[i][j] = 0;
        let mut area = 1;
        area += Self::dfs(grid, i + 1, j);
        if i > 0 {
            area += Self::dfs(grid, i - 1, j);
        }
        area += Self::dfs(grid, i, j + 1);
        if j > 0 {
            area += Self::dfs(grid, i, j - 1);
        }
        area
    }
}