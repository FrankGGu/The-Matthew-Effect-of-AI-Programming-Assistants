impl Solution {
    pub fn num_dup_digits_at_most_n(n: i32) -> i32 {
        let s = n.to_string().chars().collect::<Vec<char>>();
        let m = s.len();
        let mut dp = vec![vec![vec![-1; 1 << 10]; m]; 2];

        fn dfs(pos: usize, tight: bool, mask: usize, s: &Vec<char>, dp: &mut Vec<Vec<Vec<i32>>>, m: usize) -> i32 {
            if pos == m {
                return if mask != 0 { 1 } else { 0 };
            }
            if dp[tight as usize][pos][mask] != -1 {
                return dp[tight as usize][pos][mask];
            }
            let limit = if tight { s[pos] as u8 - b'0' } else { 9 };
            let mut res = 0;
            for d in 0..=limit {
                let new_tight = tight && (d == limit);
                let new_mask = if mask == 0 && d == 0 { 0 } else { mask | (1 << d) };
                if mask & (1 << d) != 0 {
                    continue;
                }
                res += dfs(pos + 1, new_tight, new_mask, s, dp, m);
            }
            dp[tight as usize][pos][mask] = res;
            res
        }

        let total_unique = dfs(0, true, 0, &s, &mut dp, m);
        n - total_unique
    }
}