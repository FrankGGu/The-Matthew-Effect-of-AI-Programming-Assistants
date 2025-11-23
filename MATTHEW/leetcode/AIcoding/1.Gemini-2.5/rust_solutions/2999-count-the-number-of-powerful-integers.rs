struct Solution;

impl Solution {
    pub fn count_powerful_integers(low: i64, high: i64, limit: i32, digit: i32, suffix: i64) -> i64 {
        let suffix_str = format!("{:0width$}", suffix, width = limit as usize);
        let digit_u8 = digit as u8;

        let count_up_to = |n_val: i64| -> i64 {
            if n_val < 0 {
                return 0;
            }
            let n_str = n_val.to_string();
            let n_chars: Vec<char> = n_str.chars().collect();
            let suffix_chars: Vec<char> = suffix_str.chars().collect();

            let l_n = n_chars.len();
            let l_suffix = suffix_chars.len();

            if l_n < l_suffix {
                return 0;
            }

            let mut ans = 0;

            // Part 1: Count powerful integers with length < l_n
            for current_len in l_suffix..l_n {
                let prefix_len = current_len - l_suffix;
                if prefix_len == 0 {
                    // Number is just suffix_str.
                    // It must be positive.
                    if suffix_str.parse::<i64>().unwrap() > 0 {
                        ans += 1;
                    }
                } else {
                    // We need to form a prefix of prefix_len digits.
                    // First digit of prefix: 1 to digit_u8.
                    // Remaining prefix_len - 1 digits: 0 to digit_u8.
                    if digit_u8 >= 1 {
                        let mut num_ways_for_prefix = digit_u8 as i64;
                        num_ways_for_prefix *= (digit_u8 as i64 + 1).pow((prefix_len - 1) as u32);
                        ans += num_ways_for_prefix;
                    }
                }
            }

            // Part 2: Count powerful integers with length == l_n and <= n_val
            // Use digit DP
            // memo: [idx][is_less][is_started]
            // is_less: 0 for false, 1 for true
            // is_started: 0 for false, 1 for true
            let mut memo: Vec<Vec<Vec<i64>>> = vec![vec![vec![-1; 2]; 2]; l_n];

            fn dfs(
                idx: usize,
                is_less: bool, // true if current prefix is already strictly less than N_str's prefix
                is_started: bool, // true if a non-zero digit has been placed
                n_chars: &[char],
                digit_limit: u8,
                suffix_chars: &[char],
                memo: &mut Vec<Vec<Vec<i64>>>,
            ) -> i64 {
                let l_n = n_chars.len();
                let l_suffix = suffix_chars.len();

                if idx == l_n {
                    // If we reached the end, a number of length l_n has been formed.
                    // It's powerful only if it's positive (i.e., a non-zero digit was placed).
                    return if is_started { 1 } else { 0 };
                }

                // Memoization check
                if memo[idx][is_less as usize][is_started as usize] != -1 {
                    return memo[idx][is_less as usize][is_started as usize];
                }

                let upper_bound = if is_less { 9 } else { n_chars[idx] as u8 - b'0' };
                let mut res = 0;
                let suffix_start_idx = l_n - l_suffix;

                for d in 0..=upper_bound {
                    let new_is_less = is_less || (d < upper_bound);
                    let new_is_started = is_started || (d > 0);

                    if idx < suffix_start_idx {
                        // This is the prefix part of the number
                        if new_is_started {
                            // We are past leading zeros, or placing the first non-zero digit.
                            // The digit must be <= digit_limit.
                            if d <= digit_limit {
                                res += dfs(idx + 1, new_is_less, new_is_started, n_chars, digit_limit, suffix_chars, memo);
                            }
                        } else {
                            // Still placing leading zeros (d == 0 and !is_started).
                            // This path is valid as long as the number can eventually become positive.
                            res += dfs(idx + 1, new_is_less, new_is_started, n_chars, digit_limit, suffix_chars, memo);
                        }
                    } else {
                        // This is the suffix part of the number
                        let suffix_digit_idx = idx - suffix_start_idx;
                        // The digit must match the corresponding suffix digit.
                        if d == suffix_chars[suffix_digit_idx] as u8 - b'0' {
                            res += dfs(idx + 1, new_is_less, new_is_started, n_chars, digit_limit, suffix_chars, memo);
                        }
                    }
                }

                // Store result in memo
                memo[idx][is_less as usize][is_started as usize] = res;
                res
            }

            ans += dfs(0, false, false, &n_chars, digit_u8, &suffix_chars, &mut memo);
            ans
        };

        let high_count = count_up_to(high);
        let low_minus_1_count = count_up_to(low - 1);

        high_count - low_minus_1_count
    }
}