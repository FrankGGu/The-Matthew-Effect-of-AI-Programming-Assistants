impl Solution {
    pub fn ways(pizza: Vec<String>, k: i32) -> i32 {
        let rows = pizza.len();
        let cols = pizza[0].len();
        let mut apples = vec![vec![0; cols + 1]; rows + 1];
        let mut dp = vec![vec![vec![0; cols]; rows]; k as usize];
        let MOD = 1_000_000_007;

        for i in (0..rows).rev() {
            for j in (0..cols).rev() {
                apples[i][j] = apples[i][j + 1] + apples[i + 1][j] - apples[i + 1][j + 1] +
                    if pizza[i].as_bytes()[j] == b'A' { 1 } else { 0 };
            }
        }

        fn solve(row: usize, col: usize, cuts: usize, apples: &Vec<Vec<i32>>, dp: &mut Vec<Vec<Vec<i32>>>, rows: usize, cols: usize) -> i32 {
            if apples[row][col] == 0 {
                return 0;
            }

            if cuts == 0 {
                return 1;
            }

            if dp[cuts][row][col] != 0 {
                return dp[cuts][row][col];
            }

            let mut ans = 0;
            let MOD = 1_000_000_007;

            for next_row in row + 1..rows {
                if apples[row][col] - apples[next_row][col] > 0 {
                    ans = (ans + solve(next_row, col, cuts - 1, apples, dp, rows, cols)) % MOD;
                }
            }

            for next_col in col + 1..cols {
                if apples[row][col] - apples[row][next_col] > 0 {
                    ans = (ans + solve(row, next_col, cuts - 1, apples, dp, rows, cols)) % MOD;
                }
            }

            dp[cuts][row][col] = ans;
            ans
        }

        solve(0, 0, (k - 1) as usize, &apples, &mut dp, rows, cols)
    }
}