impl Solution {
    pub fn number_of_ways(start_pos: i32, end_pos: i32, k: i32) -> i32 {
        let k = k as usize;
        let diff = (end_pos - start_pos).abs() as usize;

        if diff > k {
            return 0;
        }

        if (k - diff) % 2 != 0 {
            return 0;
        }

        let mut dp = vec![vec![0; 6001]; k + 1];
        dp[0][start_pos as usize + 3000] = 1;

        for i in 1..=k {
            for j in 0..6001 {
                if dp[i - 1][j] > 0 {
                    if j > 0 {
                        dp[i][j - 1] = (dp[i][j - 1] + dp[i - 1][j]) % 1000000007;
                    }
                    if j < 6000 {
                        dp[i][j + 1] = (dp[i][j + 1] + dp[i - 1][j]) % 1000000007;
                    }
                }
            }
        }

        dp[k][end_pos as usize + 3000]
    }
}