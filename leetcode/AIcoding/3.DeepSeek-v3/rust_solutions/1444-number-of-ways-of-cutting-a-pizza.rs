impl Solution {
    pub fn ways(pizza: Vec<String>, k: i32) -> i32 {
        let rows = pizza.len();
        let cols = pizza[0].len();
        let mut prefix = vec![vec![0; cols + 1]; rows + 1];
        for i in (0..rows).rev() {
            for j in (0..cols).rev() {
                prefix[i][j] = prefix[i + 1][j] + prefix[i][j + 1] - prefix[i + 1][j + 1] 
                    + if pizza[i].as_bytes()[j] == b'A' { 1 } else { 0 };
            }
        }
        let mut dp = vec![vec![vec![0; cols]; rows]; k as usize];
        for i in (0..rows).rev() {
            for j in (0..cols).rev() {
                dp[0][i][j] = if prefix[i][j] > 0 { 1 } else { 0 };
            }
        }
        for cuts in 1..(k as usize) {
            for i in (0..rows).rev() {
                for j in (0..cols).rev() {
                    let mut ways = 0;
                    for new_row in (i + 1)..rows {
                        if prefix[i][j] - prefix[new_row][j] > 0 {
                            ways = (ways + dp[cuts - 1][new_row][j]) % 1_000_000_007;
                        }
                    }
                    for new_col in (j + 1)..cols {
                        if prefix[i][j] - prefix[i][new_col] > 0 {
                            ways = (ways + dp[cuts - 1][i][new_col]) % 1_000_000_007;
                        }
                    }
                    dp[cuts][i][j] = ways;
                }
            }
        }
        dp[(k - 1) as usize][0][0]
    }
}