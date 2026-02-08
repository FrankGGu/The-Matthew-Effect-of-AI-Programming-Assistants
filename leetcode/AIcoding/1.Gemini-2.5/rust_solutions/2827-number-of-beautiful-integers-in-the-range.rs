struct Solution;

impl Solution {
    pub fn number_of_beautiful_integers(low: i32, high: i32, k: i32) -> i32 {
        let k_usize = k as usize;

        let count_beautiful = |mut n: i32| -> i32 {
            if n == 0 {
                return 0;
            }
            let s = n.to_string();
            let digits: Vec<u8> = s.bytes().map(|b| b - b'0').collect();
            let len = digits.len();

            // memo[idx][tight][is_leading_zero][diff_idx][current_mod]
            // diff_idx: (even_count - odd_count) + len
            // Max len is 10 (for 10^9), so diff can be from -10 to 10.
            // diff_idx will be from 0 to 20.
            // Size for diff_idx is 21.
            let mut memo = vec![vec![vec![vec![vec![-1; k_usize]; 21]; 2]; 2]; len + 1];

            // idx: current digit position (0 to len-1)
            // tight: true if we are restricted by the digits of 'n'
            // is_leading_zero: true if we are currently placing leading zeros
            // even_diff: even_count - odd_count
            // current_mod: current number modulo k
            fn dp(
                idx: usize,
                tight: bool,
                is_leading_zero: bool,
                even_diff: i32,
                current_mod: usize,
                digits: &[u8],
                k: usize,
                memo: &mut Vec<Vec<Vec<Vec<Vec<i32>>>>>,
            ) -> i32 {
                let len = digits.len();
                if idx == len {
                    // Base case: If we have processed all digits
                    // A number is beautiful if:
                    // 1. Not a leading zero (i.e., actually formed a positive number)
                    // 2. even_count == odd_count (even_diff == 0)
                    // 3. current_mod == 0 (divisible by k)
                    return if !is_leading_zero && even_diff == 0 && current_mod == 0 {
                        1
                    } else {
                        0
                    };
                }

                // Use memoized result if available
                let diff_idx = (even_diff + len as i32) as usize; // Shift diff to be non-negative
                if memo[idx][tight as usize][is_leading_zero as usize][diff_idx][current_mod] != -1
                {
                    return memo[idx][tight as usize][is_leading_zero as usize][diff_idx]
                        [current_mod];
                }

                let mut ans = 0;
                let upper_bound = if tight { digits[idx] } else { 9 };

                for digit in 0..=upper_bound {
                    if is_leading_zero && digit == 0 {
                        // Still placing leading zeros, which don't count towards even/odd or modulo
                        ans += dp(
                            idx + 1,
                            tight && (digit == upper_bound),
                            true,
                            0, // even_diff remains 0
                            0, // current_mod remains 0
                            digits,
                            k,
                            memo,
                        );
                    } else {
                        // Placed a non-zero digit or not a leading zero anymore
                        let new_even_diff = even_diff + if digit % 2 == 0 { 1 } else { -1 };
                        let new_mod = (current_mod * 10 + digit as usize) % k;
                        ans += dp(
                            idx + 1,
                            tight && (digit == upper_bound),
                            false,
                            new_even_diff,
                            new_mod,
                            digits,
                            k,
                            memo,
                        );
                    }
                }

                memo[idx][tight as usize][is_leading_zero as usize][diff_idx][current_mod] = ans;
                ans
            }

            dp(0, true, true, 0, 0, &digits, k_usize, &mut memo)
        };

        let high_count = count_beautiful(high);
        let low_minus_1_count = count_beautiful(low - 1);

        high_count - low_minus_1_count
    }
}