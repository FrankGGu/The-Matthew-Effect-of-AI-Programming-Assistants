impl Solution {
    pub fn at_most_n_given_digit_set(digits: Vec<String>, n: i32) -> i32 {
        let s_digits: Vec<char> = digits.iter().map(|s| s.chars().next().unwrap()).collect();
        let n_str: String = n.to_string();
        let n_chars: Vec<char> = n_str.chars().collect();
        let l = n_chars.len();
        let k = s_digits.len();

        let mut ans = 0;

        // Count numbers with fewer digits than n
        // For each length `i` from 1 to `L-1`, there are `k^i` such numbers.
        for i in 1..l {
            ans += (k as i32).pow(i as u32);
        }

        // Count numbers with the same number of digits as n
        let mut is_prefix_possible = true;
        for i in 0..l {
            let current_n_digit = n_chars[i];
            let mut found_equal_digit = false;

            for &d in &s_digits {
                if d < current_n_digit {
                    // If digit `d` is smaller than `n_chars[i]`,
                    // we can fill the remaining `L - 1 - i` positions with any of the `k` digits.
                    ans += (k as i32).pow((l - 1 - i) as u32);
                } else if d == current_n_digit {
                    // If digit `d` is equal to `n_chars[i]`,
                    // we must continue to the next position to potentially form a prefix of `n`.
                    found_equal_digit = true;
                } else { // d > current_n_digit
                    // If digit `d` is greater than `n_chars[i]`,
                    // any further digits in `s_digits` will also be greater.
                    // So we cannot form any more numbers with this prefix that are <= n.
                    break;
                }
            }

            if !found_equal_digit {
                // If no digit in `s_digits` matches `n_chars[i]`,
                // then we cannot form a number with `L` digits that is a prefix of `n`.
                // We've already counted all valid numbers for this prefix starting with smaller digits.
                is_prefix_possible = false;
                break;
            }
        }

        // If after checking all digits, we successfully matched `n`'s prefix,
        // it means `n` itself can be formed using the given digits.
        if is_prefix_possible {
            ans += 1;
        }

        ans
    }
}