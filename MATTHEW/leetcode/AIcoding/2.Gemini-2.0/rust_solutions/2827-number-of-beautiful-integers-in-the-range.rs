impl Solution {
    pub fn number_of_beautiful_integers(n: i32, k: i32) -> i32 {
        let s = n.to_string();
        let len = s.len();
        let mut dp = vec![vec![vec![vec![-1; 2]; k as usize]; 2]; len];

        fn solve(idx: usize, rem: i32, is_tight: bool, is_leading_zero: bool, s: &String, k: i32, dp: &mut Vec<Vec<Vec<Vec<i32>>>>>) -> i32 {
            if idx == s.len() {
                if rem == 0 && !is_leading_zero {
                    return 1;
                } else {
                    return 0;
                }
            }

            if dp[idx][is_tight as usize][rem as usize][is_leading_zero as usize] != -1 {
                return dp[idx][is_tight as usize][rem as usize][is_leading_zero as usize];
            }

            let upper_bound = if is_tight { (s.chars().nth(idx).unwrap() as i32 - '0' as i32) } else { 9 };
            let mut ans = 0;

            for digit in 0..=upper_bound {
                let new_rem = (rem + if digit % 2 == 0 { 1 } else { -1 } + k) % k;
                let new_is_tight = is_tight && (digit == upper_bound);
                let new_is_leading_zero = is_leading_zero && (digit == 0);
                ans += solve(idx + 1, new_rem, new_is_tight, new_is_leading_zero, s, k, dp);
            }

            dp[idx][is_tight as usize][rem as usize][is_leading_zero as usize] = ans;
            ans
        }

        solve(0, 0, true, true, &s, k, &mut dp)
    }
}