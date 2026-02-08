impl Solution {
    pub fn is_possible_to_cut_path(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        if !Self::dfs(&grid, 0, 0, m, n) {
            return true;
        }

        grid[0][0] = 1;
        !Self::dfs(&grid, 0, 0, m, n)
    }

    fn dfs(grid: &Vec<Vec<i32>>, i: usize, j: usize, m: usize, n: usize) -> bool {
        if i == m - 1 && j == n - 1 {
            return true;
        }

        if i >= m || j >= n || grid[i][j] == 0 {
            return false;
        }

        grid[i][j] = 0;

        let down = Self::dfs(grid, i + 1, j, m, n);
        let right = Self::dfs(grid, i, j + 1, m, n);

        down || right
    }
}