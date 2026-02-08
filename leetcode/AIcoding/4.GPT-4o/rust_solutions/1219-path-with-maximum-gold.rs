impl Solution {
    pub fn get_maximum_gold(grid: Vec<Vec<i32>>) -> i32 {
        let (rows, cols) = (grid.len(), grid[0].len());
        let mut max_gold = 0;

        fn dfs(grid: &mut Vec<Vec<i32>>, x: usize, y: usize) -> i32 {
            if x >= grid.len() || y >= grid[0].len() || grid[x][y] == 0 {
                return 0;
            }
            let gold = grid[x][y];
            grid[x][y] = 0;
            let max_gold = gold + [
                dfs(grid, x.wrapping_sub(1), y),
                dfs(grid, x + 1, y),
                dfs(grid, x, y.wrapping_sub(1)),
                dfs(grid, x, y + 1),
            ].iter().cloned().max().unwrap_or(0);
            grid[x][y] = gold;
            max_gold
        }

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] > 0 {
                    max_gold = max_gold.max(dfs(&mut grid.clone(), i, j));
                }
            }
        }

        max_gold
    }
}