impl Solution {
    pub fn unique_paths_iii(grid: Vec<Vec<i32>>) -> i32 {
        let (mut start_x, mut start_y, mut empty_count) = (0, 0, 0);
        let rows = grid.len();
        let cols = grid[0].len();

        for i in 0..rows {
            for j in 0..cols {
                match grid[i][j] {
                    1 => {
                        start_x = i;
                        start_y = j;
                    }
                    0 => empty_count += 1,
                    _ => {}
                }
            }
        }

        fn dfs(grid: &mut Vec<Vec<i32>>, x: usize, y: usize, empty_count: i32) -> i32 {
            if x < 0 || x >= grid.len() || y < 0 || y >= grid[0].len() || grid[x][y] == -1 {
                return 0;
            }
            if grid[x][y] == 2 {
                return if empty_count == 0 { 1 } else { 0 };
            }

            grid[x][y] = -1; 
            let paths = dfs(grid, x.wrapping_sub(1), y, empty_count - 1)
                + dfs(grid, x + 1, y, empty_count - 1)
                + dfs(grid, x, y.wrapping_sub(1), empty_count - 1)
                + dfs(grid, x, y + 1, empty_count - 1);
            grid[x][y] = 0; 

            paths
        }

        dfs(&mut grid.clone(), start_x, start_y, empty_count) 
    }
}