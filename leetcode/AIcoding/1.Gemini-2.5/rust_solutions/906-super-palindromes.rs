struct Solution;

impl Solution {
    fn is_palindrome(n: u64) -> bool {
        let s = n.to_string();
        let chars: Vec<char> = s.chars().collect();
        let len = chars.len();
        for i in 0..len / 2 {
            if chars[i] != chars[len - 1 - i] {
                return false;
            }
        }
        true
    }

    pub fn super_palindromes_in_range(left: String, right: String) -> i32 {
        let left_num = left.parse::<u64>().unwrap();
        let right_num = right.parse::<u64>().unwrap();
        let mut count = 0;

        // Iterate k to generate palindromes p.
        // A super palindrome N must satisfy N^2 <= right_num.
        // Since right_num <= 10^18, N must be <= sqrt(10^18) = 10^9.
        // We generate palindromes N (p_odd and p_even) from a base number k.
        // The largest palindrome N <= 10^9 is 999,999,999.
        // This palindrome is generated from k = 99,999 (odd length: 99999 + 9999 = 999999999).
        // For even length, k = 9,999 generates 99,999,999.
        // For k = 10,000, p_even would be 1,000,000,001, which is > 10^9.
        // So, iterating k from 1 up to 99,999 covers all possible base palindromes N <= 10^9.
        for k in 1..=99999 {
            let k_str = k.to_string();
            let rev_k_str: String = k_str.chars().rev().collect();

            // Form odd-length palindrome (e.g., k=123 -> 12321)
            let p_odd_str = k_str.clone() + &rev_k_str[1..];
            let p_odd = p_odd_str.parse::<u64>().unwrap();

            let p_odd_sq = p_odd * p_odd;
            if p_odd_sq > right_num {
                // If the square of the odd-length palindrome is already too large,
                // then any subsequent k will produce even larger p_odd_sq.
                // Since p_odd values grow with k, we can stop iterating entirely.
                break;
            }
            if p_odd_sq >= left_num && Self::is_palindrome(p_odd_sq) {
                count += 1;
            }

            // Form even-length palindrome (e.g., k=123 -> 123321)
            let p_even_str = k_str + &rev_k_str;
            let p_even = p_even_str.parse::<u64>().unwrap();

            let p_even_sq = p_even * p_even;
            if p_even_sq > right_num {
                // If the square of the even-length palindrome is too large,
                // we skip it but continue with the next k.
                // This is because p_odd for the next k might still be within range,
                // or p_even might become smaller relative to p_odd at some point (though unlikely here).
                continue;
            }
            if p_even_sq >= left_num && Self::is_palindrome(p_even_sq) {
                count += 1;
            }
        }

        count
    }
}