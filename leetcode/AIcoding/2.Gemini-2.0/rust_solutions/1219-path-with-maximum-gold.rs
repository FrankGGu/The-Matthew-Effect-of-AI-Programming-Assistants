impl Solution {
    pub fn get_maximum_gold(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut max_gold = 0;

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] != 0 {
                    let mut visited = vec![vec![false; n]; m];
                    max_gold = max_gold.max(Self::dfs(&grid, i, j, &mut visited));
                }
            }
        }

        max_gold
    }

    fn dfs(grid: &Vec<Vec<i32>>, row: usize, col: usize, visited: &mut Vec<Vec<bool>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        if row >= m || col >= n || visited[row][col] || grid[row][col] == 0 {
            return 0;
        }

        let gold = grid[row][col];
        visited[row][col] = true;

        let up = Self::dfs(grid, row.wrapping_sub(1), col, visited);
        let down = Self::dfs(grid, row + 1, col, visited);
        let left = Self::dfs(grid, row, col.wrapping_sub(1), visited);
        let right = Self::dfs(grid, row, col + 1, visited);

        visited[row][col] = false;

        gold + up.max(down).max(left).max(right)
    }
}