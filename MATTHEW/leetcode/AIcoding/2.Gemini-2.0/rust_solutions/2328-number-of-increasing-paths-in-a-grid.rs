impl Solution {
    pub fn count_paths(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut count = 0;
        let modulo = 1_000_000_007;

        for i in 0..m {
            for j in 0..n {
                count = (count + Self::dfs(&grid, &mut dp, i, j, modulo)) % modulo;
            }
        }

        count
    }

    fn dfs(grid: &Vec<Vec<i32>>, dp: &mut Vec<Vec<i32>>, i: usize, j: usize, modulo: i32) -> i32 {
        if dp[i][j] != 0 {
            return dp[i][j];
        }

        let m = grid.len();
        let n = grid[0].len();
        let mut count = 1;

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        for (dx, dy) in directions {
            let new_i = i as i32 + dx;
            let new_j = j as i32 + dy;

            if new_i >= 0 && new_i < m as i32 && new_j >= 0 && new_j < n as i32 {
                let new_i = new_i as usize;
                let new_j = new_j as usize;

                if grid[new_i][new_j] > grid[i][j] {
                    count = (count + Self::dfs(grid, dp, new_i, new_j, modulo)) % modulo;
                }
            }
        }

        dp[i][j] = count;
        count
    }
}