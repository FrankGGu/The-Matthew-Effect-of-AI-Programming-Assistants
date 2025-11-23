struct Solution;

impl Solution {
    const MOD: i32 = 1_000_000_007;

    fn dp_solve(
        s_chars: &[u8],
        idx: usize,
        prev_digit: i8, // Use -1 for initial state (no prev digit yet)
        is_less: bool,
        is_leading_zero: bool,
        memo: &mut Vec<Vec<Vec<Vec<i32>>>>,
    ) -> i32 {
        if idx == s_chars.len() {
            return 1; // Found one valid number
        }

        let prev_digit_idx = (prev_digit + 1) as usize; // Map -1 to 0, 0 to 1, ..., 9 to 10. Size 11.
        if memo[idx][prev_digit_idx][is_less as usize][is_leading_zero as usize] != -1 {
            return memo[idx][prev_digit_idx][is_less as usize][is_leading_zero as usize];
        }

        let mut ans = 0;
        let upper_bound = if is_less { 9 } else { s_chars[idx] - b'0' };

        for digit in 0..=upper_bound {
            if is_leading_zero {
                if digit == 0 {
                    // Still placing leading zeros. `prev_digit` doesn't apply yet.
                    ans = (ans + Self::dp_solve(s_chars, idx + 1, -1, is_less || (digit < upper_bound), true, memo)) % Self::MOD;
                } else {
                    // First non-zero digit. `prev_digit` is now set.
                    ans = (ans + Self::dp_solve(s_chars, idx + 1, digit as i8, is_less || (digit < upper_bound), false, memo)) % Self::MOD;
                }
            } else {
                // Not leading zero, apply stepping number rule
                if (digit as i8 - prev_digit).abs() == 1 {
                    ans = (ans + Self::dp_solve(s_chars, idx + 1, digit as i8, is_less || (digit < upper_bound), false, memo)) % Self::MOD;
                }
            }
        }

        memo[idx][prev_digit_idx][is_less as usize][is_leading_zero as usize] = ans;
        ans
    }

    fn count_up_to_str(s: &str) -> i32 {
        let s_chars: Vec<u8> = s.bytes().collect();
        // memo dimensions: idx, prev_digit_idx, is_less, is_leading_zero
        // prev_digit_idx: 0 for -1, 1 for 0, ..., 10 for 9 (total 11 states)
        let mut memo = vec![vec![vec![vec![-1; 2]; 2]; 11]; s_chars.len()];

        Self::dp_solve(&s_chars, 0, -1, false, true, &mut memo)
    }

    // Helper to subtract 1 from a string number.
    // Handles cases like "100" -> "99", "1" -> "0".
    fn subtract_one(s: &str) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let mut i = chars.len() - 1;

        while i > 0 && chars[i] == '0' {
            chars[i] = '9';
            i -= 1;
        }

        if chars[i] == '0' { 
            // If the first digit becomes '0' (e.g., "100" -> "099"),
            // and it's not a single-digit "0" (which would be handled by `low == "0"` special case),
            // then we drop the leading '0'. E.g., "10" -> "09" -> "9".
            if chars.len() == 1 { // "0" -> "0" (should not happen if low != "0")
                return "0".to_string();
            }
            return chars[1..].iter().collect();
        } else {
            chars[i] = (chars[i] as u8 - 1) as char;
        }

        chars.iter().collect()
    }

    pub fn count_stepping_numbers(low: String, high: String) -> i32 {
        let count_high = Self::count_up_to_str(&high);

        let count_low_minus_1 = if low == "0" {
            0 // If low is "0", we want to count from 0. Numbers less than 0 is 0.
        } else {
            Self::count_up_to_str(&Self::subtract_one(&low))
        };

        let ans = (count_high - count_low_minus_1 + Self::MOD) % Self::MOD;
        ans
    }
}