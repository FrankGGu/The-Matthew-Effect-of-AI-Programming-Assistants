fn compute_pi(s_chars: &[u8]) -> Vec<usize> {
    let m = s_chars.len();
    let mut pi = vec![0; m];
    let mut j = 0;
    for i in 1..m {
        while j > 0 && s_chars[i] != s_chars[j] {
            j = pi[j - 1];
        }
        if s_chars[i] == s_chars[j] {
            j += 1;
        }
        pi[i] = j;
    }
    pi
}

fn get_next_kmp_state(current_kmp_state: usize, digit: u8, s_chars: &[u8], pi: &[usize]) -> usize {
    let m = s_chars.len();
    if current_kmp_state == m {
        return m;
    }
    let mut j = current_kmp_state;
    let digit_char = b'0' + digit;
    while j > 0 && digit_char != s_chars[j] {
        j = pi[j - 1];
    }
    if digit_char == s_chars[j] {
        j += 1;
    }
    j
}

struct Solution;

impl Solution {
    fn count_powerful_integers_up_to(
        n_str_bytes: Vec<u8>,
        limit: u8,
        s_chars: Vec<u8>,
        pi: Vec<usize>,
    ) -> i64 {
        let n_len = n_str_bytes.len();
        let s_len = s_chars.len();

        let mut memo = vec![
            vec![
                vec![vec![-1; 2]; s_len + 1];
                2
            ];
            n_len + 1
        ];

        struct DpSolver<'a> {
            n_len: usize,
            s_len: usize,
            limit: u8,
            n_str_ref: &'a [u8],
            s_chars_ref: &'a [u8],
            pi_ref: &'a [usize],
            memo: &'a mut Vec<Vec<Vec<Vec<i64>>>>,
        }

        impl<'a> DpSolver<'a> {
            fn solve(
                &mut self,
                idx: usize,
                tight: bool,
                kmp_match_len: usize,
                is_leading_zero: bool,
            ) -> i64 {
                if idx == self.n_len {
                    return if kmp_match_len == self.s_len { 1 } else { 0 };
                }

                let tight_idx = tight as usize;
                let is_leading_zero_idx = is_leading_zero as usize;
                if self.memo[idx][tight_idx][kmp_match_len][is_leading_zero_idx] != -1 {
                    return self.memo[idx][tight_idx][kmp_match_len][is_leading_zero_idx];
                }

                let mut ans = 0;
                let upper_bound = if tight {
                    self.n_str_ref[idx] - b'0'
                } else {
                    9
                };

                for digit in 0..=upper_bound {
                    if digit > self.limit {
                        continue;
                    }

                    let new_tight = tight && (digit == upper_bound);

                    if is_leading_zero && digit == 0 {
                        ans += self.solve(idx + 1, new_tight, 0, true);
                    } else {
                        let new_kmp_match_len =
                            get_next_kmp_state(kmp_match_len, digit, self.s_chars_ref, self.pi_ref);
                        ans += self.solve(idx + 1, new_tight, new_kmp_match_len, false);
                    }
                }

                self.memo[idx][tight_idx][kmp_match_len][is_leading_zero_idx] = ans;
                ans
            }
        }

        let n_str_ref = &n_str_bytes;
        let s_chars_ref = &s_chars;
        let pi_ref = &pi;

        let mut solver = DpSolver {
            n_len,
            s_len,
            limit,
            n_str_ref,
            s_chars_ref,
            pi_ref,
            memo: &mut memo,
        };

        solver.solve(0, true, 0, true)
    }

    pub fn powerful_integers(start: i64, finish: i64, limit: i32, s: String) -> i64 {
        let s_chars: Vec<u8> = s.bytes().collect();
        let pi = compute_pi(&s_chars);

        let finish_str_bytes: Vec<u8> = finish.to_string().bytes().collect();
        let count_finish = Self::count_powerful_integers_up_to(
            finish_str_bytes,
            limit as u8,
            s_chars.clone(),
            pi.clone(),
        );

        let start_minus_1_str_bytes: Vec<u8> = (start - 1).to_string().bytes().collect();
        let count_start_minus_1 = Self::count_powerful_integers_up_to(
            start_minus_1_str_bytes,
            limit as u8,
            s_chars,
            pi,
        );

        count_finish - count_start_minus_1
    }
}