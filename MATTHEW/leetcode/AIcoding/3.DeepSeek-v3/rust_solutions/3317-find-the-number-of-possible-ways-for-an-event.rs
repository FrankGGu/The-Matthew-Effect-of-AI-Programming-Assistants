impl Solution {
    pub fn number_of_ways(n: i32, m: i32, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = n as usize;
        let m = m as usize;
        let k = k as usize;

        let mut dp = vec![vec![vec![0; m]; n]; k + 1];
        dp[0][0][0] = 1;

        for step in 1..=k {
            for i in 0..n {
                for j in 0..m {
                    let mut ways = 0;
                    for &(di, dj) in &[(-1, 0), (1, 0), (0, -1), (0, 1)] {
                        let ni = i as i32 + di;
                        let nj = j as i32 + dj;
                        if ni >= 0 && ni < n as i32 && nj >= 0 && nj < m as i32 {
                            ways = (ways + dp[step - 1][ni as usize][nj as usize]) % MOD;
                        }
                    }
                    dp[step][i][j] = ways;
                }
            }
        }

        dp[k][n - 1][m - 1]
    }
}