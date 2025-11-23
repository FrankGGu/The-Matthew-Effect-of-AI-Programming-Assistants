struct Solution;

impl Solution {
    pub fn is_possible(grid: Vec<Vec<i32>>) -> bool {
        let mut sum = 0;
        for row in &grid {
            for &val in row {
                sum += val;
            }
        }
        if sum % 2 != 0 {
            return false;
        }
        let target = sum / 2;
        let rows = grid.len();
        let cols = grid[0].len();

        fn dfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize, target: i32) -> bool {
            if target == 0 {
                return true;
            }
            if i >= grid.len() || j >= grid[0].len() || visited[i][j] {
                return false;
            }
            visited[i][j] = true;
            let res = dfs(grid, visited, i + 1, j, target - grid[i][j])
                || dfs(grid, visited, i, j + 1, target - grid[i][j])
                || dfs(grid, visited, i - 1, j, target - grid[i][j])
                || dfs(grid, visited, i, j - 1, target - grid[i][j]);
            visited[i][j] = false;
            res
        }

        for i in 0..rows {
            for j in 0..cols {
                let mut visited = vec![vec![false; cols]; rows];
                if dfs(&grid, &mut visited, i, j, target) {
                    return true;
                }
            }
        }
        false
    }
}