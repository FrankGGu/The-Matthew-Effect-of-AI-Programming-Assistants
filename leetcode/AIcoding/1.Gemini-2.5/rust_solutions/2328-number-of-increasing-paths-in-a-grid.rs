const MOD: i32 = 1_000_000_007;

impl Solution {
    fn solve(r: usize, c: usize, m: usize, n: usize, grid: &Vec<Vec<i32>>, memo: &mut Vec<Vec<i32>>) -> i32 {
        if memo[r][c] != 0 {
            return memo[r][c];
        }

        let mut paths = 1;

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let nr = r as isize + dr[i];
            let nc = c as isize + dc[i];

            if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                let nr_usize = nr as usize;
                let nc_usize = nc as usize;
                if grid[nr_usize][nc_usize] > grid[r][c] {
                    paths = (paths + Self::solve(nr_usize, nc_usize, m, n, grid, memo)) % MOD;
                }
            }
        }

        memo[r][c] = paths;
        paths
    }

    pub fn count_paths(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut memo = vec![vec![0; n]; m];
        let mut total_paths = 0;

        for r in 0..m {
            for c in 0..n {
                total_paths = (total_paths + Self::solve(r, c, m, n, &grid, &mut memo)) % MOD;
            }
        }

        total_paths
    }
}