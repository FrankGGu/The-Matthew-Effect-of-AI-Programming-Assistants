impl Solution {
    pub fn count_special_numbers(n: i32) -> i32 {
        let s = n.to_string();
        let digits: Vec<char> = s.chars().collect();
        let m = digits.len();
        let mut memo = vec![vec![vec![-1; 1 << 10]; 2]; m];

        fn dfs(pos: usize, tight: bool, mask: usize, digits: &Vec<char>, memo: &mut Vec<Vec<Vec<i32>>>, m: usize) -> i32 {
            if pos == m {
                return if mask != 0 { 1 } else { 0 };
            }
            if memo[pos][tight as usize][mask] != -1 {
                return memo[pos][tight as usize][mask];
            }
            let limit = if tight { digits[pos] as u8 - b'0' } else { 9 };
            let mut res = 0;
            for d in 0..=limit {
                let new_tight = tight && (d == limit);
                let new_mask = if mask == 0 && d == 0 { 0 } else { mask | (1 << d) };
                if (mask & (1 << d)) != 0 {
                    continue;
                }
                res += dfs(pos + 1, new_tight, new_mask, digits, memo, m);
            }
            memo[pos][tight as usize][mask] = res;
            res
        }

        dfs(0, true, 0, &digits, &mut memo, m)
    }
}