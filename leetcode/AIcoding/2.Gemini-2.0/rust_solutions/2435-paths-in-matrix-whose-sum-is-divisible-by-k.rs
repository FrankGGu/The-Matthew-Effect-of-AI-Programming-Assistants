impl Solution {
    pub fn number_of_paths(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let k = k as usize;
        let mut dp = vec![vec![vec![0; k]; n]; m];
        dp[0][0][(grid[0][0] as usize) % k] = 1;

        for i in 0..m {
            for j in 0..n {
                for rem in 0..k {
                    let next_rem = ((rem + (grid[i][j] as usize)) % k) as usize;

                    if i > 0 {
                        dp[i][j][next_rem] = (dp[i][j][next_rem] + dp[i - 1][j][rem]) % 1000000007;
                    }
                    if j > 0 {
                        dp[i][j][next_rem] = (dp[i][j][next_rem] + dp[i][j - 1][rem]) % 1000000007;
                    }
                }
            }
        }

        dp[m - 1][n - 1][0]
    }
}