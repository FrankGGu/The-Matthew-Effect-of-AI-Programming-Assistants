impl Solution {
    pub fn min_days(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();

        fn count_islands(grid: &Vec<Vec<i32>>) -> i32 {
            let mut grid = grid.clone();
            let rows = grid.len();
            let cols = grid[0].len();
            let mut count = 0;

            fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize) {
                if i < 0 || i >= grid.len() || j < 0 || j >= grid[0].len() || grid[i][j] == 0 {
                    return;
                }
                grid[i][j] = 0;
                dfs(grid, i + 1, j);
                dfs(grid, i - 1, j);
                dfs(grid, i, j + 1);
                dfs(grid, i, j - 1);
            }

            for i in 0..rows {
                for j in 0..cols {
                    if grid[i][j] == 1 {
                        count += 1;
                        dfs(&mut grid, i, j);
                    }
                }
            }

            count
        }

        let island_count = count_islands(&grid);

        if island_count == 0 || island_count > 1 {
            return 0;
        }

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    let mut temp_grid = grid.clone();
                    temp_grid[i][j] = 0;
                    if count_islands(&temp_grid) != 1 {
                        return 1;
                    }
                }
            }
        }

        2
    }
}