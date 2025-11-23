impl Solution {
    pub fn count_stepping_numbers(low: String, high: String) -> i32 {
        let low_num: i64 = low.parse().unwrap();
        let high_num: i64 = high.parse().unwrap();

        Self::count_stepping_numbers_helper(high_num) - Self::count_stepping_numbers_helper(low_num - 1)
    }

    fn count_stepping_numbers_helper(n: i64) -> i32 {
        let s = n.to_string();
        let len = s.len();
        let mut memo = vec![vec![vec![-1; 2]; 11]; len];
        Self::dfs(0, -1, true, &s.chars().collect::<Vec<_>>(), &mut memo)
    }

    fn dfs(idx: usize, prev_digit: i32, tight: bool, s: &Vec<char>, memo: &mut Vec<Vec<Vec<i32>>>) -> i32 {
        if idx == s.len() {
            return 1;
        }

        if memo[idx][if prev_digit == -1 { 10 } else { prev_digit as usize }][if tight { 1 } else { 0 }] != -1 {
            return memo[idx][if prev_digit == -1 { 10 } else { prev_digit as usize }][if tight { 1 } else { 0 }];
        }

        let mut ans = 0;
        let upper_bound = if tight { (s[idx] as u8 - b'0') as i32 } else { 9 };

        for digit in 0..=upper_bound {
            if prev_digit == -1 || (prev_digit - digit).abs() == 1 {
                ans += Self::dfs(
                    idx + 1,
                    digit,
                    tight && (digit == upper_bound),
                    s,
                    memo,
                );
            }
        }

        memo[idx][if prev_digit == -1 { 10 } else { prev_digit as usize }][if tight { 1 } else { 0 }] = ans;
        ans
    }
}