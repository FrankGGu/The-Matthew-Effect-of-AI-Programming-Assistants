struct Solution;

impl Solution {
    pub fn hit_brick(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut grid = grid;
        let rows = grid.len();
        let cols = grid[0].len();
        let mut result = vec![];

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    let count = Self::dfs(&mut grid, i, j);
                    result.push(vec![i as i32, j as i32, count as i32]);
                }
            }
        }

        result
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize) -> i32 {
        if i < 0 || i >= grid.len() || j < 0 || j >= grid[0].len() || grid[i][j] != 1 {
            return 0;
        }

        grid[i][j] = 0;
        let mut count = 1;

        count += Self::dfs(grid, i + 1, j);
        count += Self::dfs(grid, i - 1, j);
        count += Self::dfs(grid, i, j + 1);
        count += Self::dfs(grid, i, j - 1);

        count
    }
}