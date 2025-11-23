struct Solution;

impl Solution {
    pub fn max_magic_cells(grid: Vec<Vec<i32>>) -> i32 {
        if grid.is_empty() || grid[0].is_empty() {
            return 0;
        }

        let n = grid.len();
        let m = grid[0].len();

        let mut match_to: Vec<i32> = vec![-1; m];
        let mut result = 0;

        for i in 0..n {
            let mut visited: Vec<bool> = vec![false; m];
            if Self::dfs_find_path(i, &grid, &mut match_to, &mut visited) {
                result += 1;
            }
        }

        result
    }

    fn dfs_find_path(
        u: usize,
        grid: &Vec<Vec<i32>>,
        match_to: &mut Vec<i32>,
        visited: &mut Vec<bool>,
    ) -> bool {
        let m = grid[0].len();

        for v in 0..m {
            if grid[u][v] == 1 && !visited[v] {
                visited[v] = true;

                if match_to[v] == -1 || Self::dfs_find_path(match_to[v] as usize, grid, match_to, visited) {
                    match_to[v] = u as i32;
                    return true;
                }
            }
        }
        false
    }
}