impl Solution {
    pub fn count_special_integers(n: i32) -> i32 {
        let s = n.to_string();
        let len = s.len();
        let mut dp = vec![vec![-1; 1 << 10]; len + 1];

        fn dfs(i: usize, mask: i32, is_limit: bool, is_num: bool, s: &String, dp: &mut Vec<Vec<i32>>) -> i32 {
            if i == s.len() {
                return if is_num { 1 } else { 0 };
            }

            if !is_limit && is_num && dp[i][mask as usize] != -1 {
                return dp[i][mask as usize];
            }

            let mut res = 0;
            if !is_num {
                res += dfs(i + 1, mask, false, false, s, dp);
            }

            let up = if is_limit { s.chars().nth(i).unwrap().to_digit(10).unwrap() as i32 } else { 9 };

            let start = if is_num { 0 } else { 1 };
            for d in start..=up {
                if (mask & (1 << d)) == 0 {
                    res += dfs(i + 1, mask | (1 << d), is_limit && d == up, true, s, dp);
                }
            }

            if !is_limit && is_num {
                dp[i][mask as usize] = res;
            }

            res
        }

        dfs(0, 0, true, false, &s, &mut dp)
    }
}