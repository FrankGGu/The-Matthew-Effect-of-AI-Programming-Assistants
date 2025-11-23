impl Solution {
    pub fn closed_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let mut closed_island_count = 0;
        let rows = grid.len();
        let cols = grid[0].len();

        fn dfs(grid: &mut Vec<Vec<i32>>, x: usize, y: usize) -> bool {
            if x >= grid.len() || y >= grid[0].len() {
                return false;
            }
            if grid[x][y] == 1 {
                return true;
            }
            grid[x][y] = 1;
            let up = dfs(grid, x.wrapping_sub(1), y);
            let down = dfs(grid, x + 1, y);
            let left = dfs(grid, x, y.wrapping_sub(1));
            let right = dfs(grid, x, y + 1);
            up && down && left && right
        }

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 0 {
                    if dfs(&mut grid, i, j) {
                        closed_island_count += 1;
                    }
                }
            }
        }

        closed_island_count
    }
}