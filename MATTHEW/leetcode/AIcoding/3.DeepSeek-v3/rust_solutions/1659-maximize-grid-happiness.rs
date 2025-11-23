impl Solution {
    pub fn get_max_grid_happiness(m: i32, n: i32, introverts_count: i32, extroverts_count: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let max_state = 3i32.pow(n as u32) as usize;
        let mut dp = vec![vec![vec![vec![-1; max_state]; extroverts_count as usize + 1]; introverts_count as usize + 1]; m * n + 1];

        fn dfs(pos: usize, i_remain: usize, e_remain: usize, prev_state: usize, m: usize, n: usize, max_state: usize, dp: &mut Vec<Vec<Vec<Vec<i32>>>>) -> i32 {
            if pos == m * n {
                return 0;
            }
            if dp[pos][i_remain][e_remain][prev_state] != -1 {
                return dp[pos][i_remain][e_remain][prev_state];
            }
            let row = pos / n;
            let col = pos % n;
            let up = if row == 0 { 0 } else { (prev_state / 3usize.pow((n - 1) as u32)) % 3 };
            let left = if col == 0 { 0 } else { prev_state % 3 };

            let mut res = dfs(pos + 1, i_remain, e_remain, (prev_state * 3) % max_state, m, n, max_state, dp);

            if i_remain > 0 {
                let mut happiness = 120;
                if up == 1 {
                    happiness -= 30 * 2;
                } else if up == 2 {
                    happiness += 20 - 30;
                }
                if left == 1 {
                    happiness -= 30 * 2;
                } else if left == 2 {
                    happiness += 20 - 30;
                }
                let new_state = prev_state * 3 % max_state + 1;
                res = res.max(happiness + dfs(pos + 1, i_remain - 1, e_remain, new_state, m, n, max_state, dp));
            }

            if e_remain > 0 {
                let mut happiness = 40;
                if up == 1 {
                    happiness += 20 - 30;
                } else if up == 2 {
                    happiness += 20 * 2;
                }
                if left == 1 {
                    happiness += 20 - 30;
                } else if left == 2 {
                    happiness += 20 * 2;
                }
                let new_state = prev_state * 3 % max_state + 2;
                res = res.max(happiness + dfs(pos + 1, i_remain, e_remain - 1, new_state, m, n, max_state, dp));
            }

            dp[pos][i_remain][e_remain][prev_state] = res;
            res
        }

        dfs(0, introverts_count as usize, extroverts_count as usize, 0, m, n, max_state, &mut dp)
    }
}