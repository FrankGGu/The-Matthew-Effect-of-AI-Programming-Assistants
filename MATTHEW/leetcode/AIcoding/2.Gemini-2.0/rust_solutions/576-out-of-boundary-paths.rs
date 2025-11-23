impl Solution {
    pub fn find_paths(m: i32, n: i32, max_move: i32, start_row: i32, start_column: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let max_move = max_move as usize;
        let start_row = start_row as usize;
        let start_column = start_column as usize;

        let mut dp = vec![vec![vec![0; n]; m]; max_move + 1];
        let modulo: i64 = 1000000007;
        let mut count: i64 = 0;

        for moves in 1..=max_move {
            for i in 0..m {
                for j in 0..n {
                    if i == 0 {
                        count = (count + 1) % modulo;
                        dp[moves][i][j] = (dp[moves][i][j] + 1) % modulo;
                    }
                    if i == m - 1 {
                        count = (count + 1) % modulo;
                        dp[moves][i][j] = (dp[moves][i][j] + 1) % modulo;
                    }
                    if j == 0 {
                        count = (count + 1) % modulo;
                        dp[moves][i][j] = (dp[moves][i][j] + 1) % modulo;
                    }
                    if j == n - 1 {
                        count = (count + 1) % modulo;
                        dp[moves][i][j] = (dp[moves][i][j] + 1) % modulo;
                    }

                    if i > 0 {
                        dp[moves][i][j] = (dp[moves][i][j] + dp[moves - 1][i - 1][j]) % modulo;
                    }
                    if i < m - 1 {
                        dp[moves][i][j] = (dp[moves][i][j] + dp[moves - 1][i + 1][j]) % modulo;
                    }
                    if j > 0 {
                        dp[moves][i][j] = (dp[moves][i][j] + dp[moves - 1][i][j - 1]) % modulo;
                    }
                    if j < n - 1 {
                        dp[moves][i][j] = (dp[moves][i][j] + dp[moves - 1][i][j + 1]) % modulo;
                    }
                }
            }
        }

        dp[max_move][start_row][start_column] as i32
    }
}