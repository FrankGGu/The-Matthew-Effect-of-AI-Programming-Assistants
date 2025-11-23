struct Solution;

impl Solution {
    pub fn count_special_integers(n: i32) -> i32 {
        let s = n.to_string();
        let s_chars: Vec<char> = s.chars().collect();
        let len = s_chars.len();

        let mut memo: Vec<Vec<Vec<Vec<Option<i32>>>>> =
            vec![vec![vec![vec![None; 2]; 2]; 1 << 10]; len + 1];

        let result = Self::dp(0, 0, true, true, &s_chars, &mut memo);

        result - 1
    }

    fn dp(
        idx: usize,
        mask: i32,
        tight: bool,
        is_zero: bool,
        s_chars: &[char],
        memo: &mut Vec<Vec<Vec<Vec<Option<i32>>>>>,
    ) -> i32 {
        if idx == s_chars.len() {
            return 1;
        }

        let tight_idx = tight as usize;
        let is_zero_idx = is_zero as usize;

        if let Some(res) = memo[idx][mask as usize][tight_idx][is_zero_idx] {
            return res;
        }

        let mut ans = 0;
        let upper_bound = if tight {
            s_chars[idx].to_digit(10).unwrap() as i32
        } else {
            9
        };

        for digit in 0..=upper_bound {
            if is_zero {
                if digit == 0 {
                    ans += Self::dp(idx + 1, mask, tight && (digit == upper_bound), true, s_chars, memo);
                } else {
                    if (mask & (1 << digit)) == 0 {
                        ans += Self::dp(idx + 1, mask | (1 << digit), tight && (digit == upper_bound), false, s_chars, memo);
                    }
                }
            } else {
                if (mask & (1 << digit)) == 0 {
                    ans += Self::dp(idx + 1, mask | (1 << digit), tight && (digit == upper_bound), false, s_chars, memo);
                }
            }
        }

        memo[idx][mask as usize][tight_idx][is_zero_idx] = Some(ans);
        ans
    }
}