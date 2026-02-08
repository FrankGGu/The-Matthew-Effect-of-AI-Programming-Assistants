impl Solution {
    pub fn is_possible_to_cut_path(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        if m == 1 && n == 1 {
            return false;
        }

        let mut visited = vec![vec![false; n]; m];

        fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize, visited: &mut Vec<Vec<bool>>) -> bool {
            let m = grid.len();
            let n = grid[0].len();

            if i == m - 1 && j == n - 1 {
                return true;
            }

            visited[i][j] = true;

            if i + 1 < m && grid[i + 1][j] == 1 && !visited[i + 1][j] {
                if dfs(grid, i + 1, j, visited) {
                    return true;
                }
            }

            if j + 1 < n && grid[i][j + 1] == 1 && !visited[i][j + 1] {
                if dfs(grid, i, j + 1, visited) {
                    return true;
                }
            }

            false
        }

        let mut grid1 = grid.clone();
        let mut visited1 = vec![vec![false; n]; m];

        if !dfs(&mut grid1, 0, 0, &mut visited1) {
            return true;
        }

        let mut grid2 = grid.clone();
        let mut visited2 = vec![vec![false; n]; m];

        let mut found = false;
        for i in 0..m {
            for j in 0..n {
                if visited1[i][j] {
                    grid2[i][j] = 0;
                    if !dfs(&mut grid2, 0, 0, &mut visited2) {
                        found = true;
                        break;
                    }
                    grid2[i][j] = 1;
                    visited2 = vec![vec![false; n]; m];
                }
            }
            if found {
                break;
            }
        }

        found
    }
}