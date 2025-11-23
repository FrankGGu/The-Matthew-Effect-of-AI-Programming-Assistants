impl Solution {
    pub fn ways(pizza: Vec<String>, k: i32) -> i32 {
        let rows = pizza.len();
        let cols = pizza[0].len();
        let k = k as usize;
        let modulo = 1_000_000_007;

        let mut apples = vec![vec![0; cols + 1]; rows + 1];
        for r in (0..rows).rev() {
            for c in (0..cols).rev() {
                let val = if pizza[r].as_bytes()[c] == b'A' { 1 } else { 0 };
                apples[r][c] = val + apples[r + 1][c] + apples[r][c + 1] - apples[r + 1][c + 1];
            }
        }

        let has_apple = |r1: usize, c1: usize, r2: usize, c2: usize| -> bool {
            apples[r1][c1] - apples[r2 + 1][c1] - apples[r1][c2 + 1] + apples[r2 + 1][c2 + 1] > 0
        };

        let mut dp = vec![vec![vec![0; cols]; rows]; k];

        for r in 0..rows {
            for c in 0..cols {
                if has_apple(r, c, rows - 1, cols - 1) {
                    dp[0][r][c] = 1;
                }
            }
        }

        for k_idx in 1..k {
            for r in (0..rows).rev() {
                for c in (0..cols).rev() {
                    let mut current_ways = 0;

                    for next_r in (r + 1)..rows {
                        if has_apple(r, c, next_r - 1, cols - 1) {
                            current_ways = (current_ways + dp[k_idx - 1][next_r][c]) % modulo;
                        }
                    }

                    for next_c in (c + 1)..cols {
                        if has_apple(r, c, rows - 1, next_c - 1) {
                            current_ways = (current_ways + dp[k_idx - 1][r][next_c]) % modulo;
                        }
                    }
                    dp[k_idx][r][c] = current_ways;
                }
            }
        }

        dp[k - 1][0][0]
    }
}