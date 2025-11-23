impl Solution {
    pub fn count_paths(grid: Vec<Vec<i32>>) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![1; n]; m];
        let mut cells = Vec::new();

        for i in 0..m {
            for j in 0..n {
                cells.push((grid[i][j], i, j));
            }
        }

        cells.sort_unstable();

        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        for &(val, i, j) in cells.iter() {
            for &(di, dj) in dirs.iter() {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if grid[ni][nj] < val {
                        dp[i][j] = (dp[i][j] + dp[ni][nj]) % MOD;
                    }
                }
            }
        }

        let mut res = 0;
        for i in 0..m {
            for j in 0..n {
                res = (res + dp[i][j]) % MOD;
            }
        }

        res as i32
    }
}