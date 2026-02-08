impl Solution {
    pub fn count_special_numbers(n: i32) -> i32 {
        let s = n.to_string();
        let len = s.len();
        let mut dp = vec![vec![vec![0; 1 << 10]; 2]; len + 1];

        fn dfs(i: usize, mask: usize, is_limit: bool, is_num: bool, s: &String, dp: &mut Vec<Vec<Vec<i32>>>) -> i32 {
            if i == s.len() {
                return if is_num { 1 } else { 0 };
            }

            if !is_limit && is_num && dp[i][is_limit as usize][mask] != -1 {
                return dp[i][is_limit as usize][mask];
            }

            let mut res = 0;

            if !is_num {
                res += dfs(i + 1, mask, false, false, s, dp);
            }

            let up = if is_limit { s.chars().nth(i).unwrap() as u8 - b'0' } else { 9 };

            for d in (if is_num { 0 } else { 1 })..=up {
                let d = d as usize;
                if mask & (1 << d) == 0 {
                    res += dfs(i + 1, mask | (1 << d), is_limit && (d as u8 == s.chars().nth(i).unwrap() as u8 - b'0'), true, s, dp);
                }
            }

            if !is_limit && is_num {
                dp[i][is_limit as usize][mask] = res;
            }

            res
        }

        for i in 0..=len {
            for j in 0..2 {
                for k in 0..(1 << 10) {
                    dp[i][j][k] = -1;
                }
            }
        }

        dfs(0, 0, true, false, &s, &mut dp)
    }
}