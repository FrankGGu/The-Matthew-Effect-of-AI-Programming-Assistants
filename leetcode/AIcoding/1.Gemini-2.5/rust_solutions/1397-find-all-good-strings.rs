struct Solution;

impl Solution {
    const MOD: i32 = 1_000_000_007;

    fn compute_lps(evil_chars: &[char]) -> Vec<usize> {
        let m = evil_chars.len();
        let mut lps = vec![0; m];
        let mut length = 0;
        let mut i = 1;
        while i < m {
            if evil_chars[i] == evil_chars[length] {
                length += 1;
                lps[i] = length;
                i += 1;
            } else {
                if length != 0 {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i += 1;
                }
            }
        }
        lps
    }

    fn solve(
        idx: usize,
        evil_match_len: usize,
        tight_s1: bool,
        tight_s2: bool,
        n: usize,
        s1_chars: &[char],
        s2_chars: &[char],
        evil_chars: &[char],
        lps: &[usize],
        memo: &mut Vec<Vec<Vec<Vec<i32>>>>,
    ) -> i32 {
        if evil_match_len == evil_chars.len() {
            return 0;
        }
        if idx == n {
            return 1;
        }

        let ts1_idx = tight_s1 as usize;
        let ts2_idx = tight_s2 as usize;

        if memo[idx][evil_match_len][ts1_idx][ts2_idx] != -1 {
            return memo[idx][evil_match_len][ts1_idx][ts2_idx];
        }

        let mut ans = 0;
        let lower_bound = if tight_s1 { s1_chars[idx] } else { 'a' };
        let upper_bound = if tight_s2 { s2_chars[idx] } else { 'z' };

        for char_code in lower_bound as u8..=upper_bound as u8 {
            let ch = char_code as char;

            let mut current_evil_match = evil_match_len;
            while current_evil_match > 0 && evil_chars[current_evil_match] != ch {
                current_evil_match = lps[current_evil_match - 1];
            }
            if evil_chars[current_evil_match] == ch {
                current_evil_match += 1;
            }

            let next_tight_s1 = tight_s1 && (ch == s1_chars[idx]);
            let next_tight_s2 = tight_s2 && (ch == s2_chars[idx]);

            ans = (ans + Self::solve(
                idx + 1,
                current_evil_match,
                next_tight_s1,
                next_tight_s2,
                n,
                s1_chars,
                s2_chars,
                evil_chars,
                lps,
                memo,
            )) % Self::MOD;
        }

        memo[idx][evil_match_len][ts1_idx][ts2_idx] = ans;
        ans
    }

    pub fn find_good_strings(n: i32, s1: String, s2: String, evil: String) -> i32 {
        let n = n as usize;
        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();
        let evil_chars: Vec<char> = evil.chars().collect();
        let evil_len = evil_chars.len();

        let lps = Self::compute_lps(&evil_chars);

        let mut memo = vec![
            vec![
                vec![vec![-1; 2]; 2];
                evil_len + 1
            ];
            n
        ];

        Self::solve(
            0,
            0,
            true,
            true,
            n,
            &s1_chars,
            &s2_chars,
            &evil_chars,
            &lps,
            &mut memo,
        )
    }
}