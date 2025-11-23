impl Solution {
    pub fn is_possible_to_cut_path(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let mut visited = vec![vec![false; n]; m];

        if !Self::dfs(&grid, 0, 0, &mut visited, m, n) {
            return true;
        }

        visited = vec![vec![false; n]; m];
        !Self::dfs(&grid, 0, 0, &mut visited, m, n)
    }

    fn dfs(grid: &Vec<Vec<i32>>, i: usize, j: usize, visited: &mut Vec<Vec<bool>>, m: usize, n: usize) -> bool {
        if i == m - 1 && j == n - 1 {
            return true;
        }
        if i >= m || j >= n || grid[i][j] == 0 || visited[i][j] {
            return false;
        }
        visited[i][j] = true;
        (i + 1 < m && Self::dfs(grid, i + 1, j, visited, m, n)) || 
        (j + 1 < n && Self::dfs(grid, i, j + 1, visited, m, n))
    }
}