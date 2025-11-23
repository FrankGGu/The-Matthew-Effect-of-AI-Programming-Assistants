struct Solution;

impl Solution {
    fn count(
        index: usize,
        tight: bool,
        is_started: bool,
        sum_mod_k: usize,
        current_length: usize,
        digits: &[u8],
        k: usize,
        memo: &mut Vec<Vec<Vec<Vec<Vec<i64>>>>>,
    ) -> i64 {
        if index == digits.len() {
            if is_started && current_length % 2 == 0 && sum_mod_k == 0 {
                return 1;
            } else {
                return 0;
            }
        }

        let tight_idx = tight as usize;
        let is_started_idx = is_started as usize;
        if memo[index][tight_idx][is_started_idx][sum_mod_k][current_length] != -1 {
            return memo[index][tight_idx][is_started_idx][sum_mod_k][current_length];
        }

        let mut ans = 0;
        let limit = if tight { digits[index] } else { 9 };

        for digit in 0..=limit {
            let new_tight = tight && (digit == limit);

            if !is_started && digit == 0 {
                ans += Self::count(
                    index + 1,
                    new_tight,
                    false,
                    0,
                    0,
                    digits,
                    k,
                    memo,
                );
            } else {
                let new_is_started = true;
                let new_sum_mod_k = (sum_mod_k + digit as usize) % k;
                let new_current_length = current_length + 1;
                ans += Self::count(
                    index + 1,
                    new_tight,
                    true,
                    new_sum_mod_k,
                    new_current_length,
                    digits,
                    k,
                    memo,
                );
            }
        }

        memo[index][tight_idx][is_started_idx][sum_mod_k][current_length] = ans;
        ans
    }

    pub fn count_beautiful_numbers(num: i32, k: i32) -> i32 {
        let s = num.to_string();
        let digits: Vec<u8> = s.chars().map(|c| c.to_digit(10).unwrap() as u8).collect();
        let k_usize = k as usize;

        let max_len = digits.len();

        let mut memo = vec![
            vec![
                vec![
                    vec![
                        vec![-1; max_len + 1];
                        k_usize
                    ];
                    2
                ];
                2
            ];
            max_len + 1
        ];

        Self::count(0, true, false, 0, 0, &digits, k_usize, &mut memo) as i32
    }
}