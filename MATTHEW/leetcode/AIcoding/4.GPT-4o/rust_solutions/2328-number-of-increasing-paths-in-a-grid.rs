impl Solution {
    pub fn count_increasing_paths(grid: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashMap;

        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![-1; n]; m];
        let mod_val = 1_000_000_007;

        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];

        fn dfs(x: usize, y: usize, grid: &Vec<Vec<i32>>, dp: &mut Vec<Vec<i32>>, directions: &Vec<(i32, i32)>) -> i32 {
            if dp[x][y] != -1 {
                return dp[x][y];
            }
            let mut count = 1;

            for (dx, dy) in directions.iter() {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;

                if nx >= 0 && nx < grid.len() as i32 && ny >= 0 && ny < grid[0].len() as i32 && grid[nx as usize][ny as usize] > grid[x][y] {
                    count = (count + dfs(nx as usize, ny as usize, grid, dp, directions)) % mod_val;
                }
            }
            dp[x][y] = count;
            count
        }

        let mut total_paths = 0;
        for i in 0..m {
            for j in 0..n {
                total_paths = (total_paths + dfs(i, j, &grid, &mut dp, &directions)) % mod_val;
            }
        }
        total_paths
    }
}