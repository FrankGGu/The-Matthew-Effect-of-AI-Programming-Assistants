impl Solution {
    pub fn get_max_grid_happiness(m: i32, n: i32, introverts_count: i32, extroverts_count: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let introverts_count = introverts_count as usize;
        let extroverts_count = extroverts_count as usize;

        let mut dp = vec![vec![vec![vec![vec![-1; 1 << (n * 2)]; extroverts_count + 1]; introverts_count + 1]; m + 1];

        fn solve(
            m: usize,
            n: usize,
            row: usize,
            col: usize,
            introverts: usize,
            extroverts: usize,
            mask: usize,
            dp: &mut Vec<Vec<Vec<Vec<Vec<i32>>>>>
        ) -> i32 {
            if row == m {
                return 0;
            }

            if dp[row][introverts][extroverts][col][mask] != -1 {
                return dp[row][introverts][extroverts][col][mask];
            }

            let next_row = if col == n - 1 { row + 1 } else { row };
            let next_col = if col == n - 1 { 0 } else { col + 1 };
            let mut ans = solve(m, n, next_row, next_col, introverts, extroverts, (mask << 2 & ((1 << (n * 2)) - 1)), dp);

            if introverts > 0 {
                let mut score = 120;
                if col > 0 && (mask & 2) != 0 {
                    score -= 30;
                }
                if row > 0 && (mask & (1 << (n * 1))) != 0 {
                    score -= 30;
                }

                ans = ans.max(solve(m, n, next_row, next_col, introverts - 1, extroverts, ((mask << 2 | 1) & ((1 << (n * 2)) - 1)), dp) + score);
            }

            if extroverts > 0 {
                let mut score = 40;
                if col > 0 && (mask & 2) != 0 {
                    score += 20;
                }
                if row > 0 && (mask & (1 << (n * 1))) != 0 {
                    score += 20;
                }

                ans = ans.max(solve(m, n, next_row, next_col, introverts, extroverts - 1, ((mask << 2 | 2) & ((1 << (n * 2)) - 1)), dp) + score);
            }

            dp[row][introverts][extroverts][col][mask] = ans;
            ans
        }

        solve(m, n, 0, 0, introverts_count, extroverts_count, 0, &mut dp)
    }
}