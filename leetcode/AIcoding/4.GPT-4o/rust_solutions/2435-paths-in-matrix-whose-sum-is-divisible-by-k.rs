impl Solution {
    pub fn count_paths(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut dp = vec![vec![vec![0; k as usize]; n]; m];
        dp[0][0][(matrix[0][0] % k + k) % k] = 1;

        for i in 0..m {
            for j in 0..n {
                for mod_k in 0..k {
                    if i == 0 && j == 0 {
                        continue;
                    }
                    if i > 0 {
                        dp[i][j][(mod_k + matrix[i][j] % k + k) as usize % k] += dp[i - 1][j][mod_k as usize];
                    }
                    if j > 0 {
                        dp[i][j][(mod_k + matrix[i][j] % k + k) as usize % k] += dp[i][j - 1][mod_k as usize];
                    }
                }
                for mod_k in 0..k {
                    dp[i][j][mod_k as usize] %= 1_000_000_007;
                }
            }
        }

        let mut count = 0;
        for i in 0..m {
            for j in 0..n {
                count += dp[i][j][0];
                count %= 1_000_000_007;
            }
        }

        count
    }
}