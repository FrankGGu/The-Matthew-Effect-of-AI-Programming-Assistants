use std::collections::BTreeSet;

struct Solution;

impl Solution {
    fn is_palindrome_base_k(mut num: i64, k: i32) -> bool {
        if num == 0 {
            return true;
        }
        let mut digits = Vec::new();
        while num > 0 {
            digits.push((num % k as i64) as u8);
            num /= k as i64;
        }
        let mut left = 0;
        let mut right = digits.len() - 1;
        while left < right {
            if digits[left] != digits[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }

    pub fn sum_k_mirror_numbers(n: i32, k: i32) -> i64 {
        let mut k_mirror_numbers = BTreeSet::new();
        let mut i = 1;

        while k_mirror_numbers.len() < n as usize {
            let s_i = i.to_string();

            // Generate odd length palindrome from 'i'
            let suffix_rev_odd: String = s_i.chars().rev().skip(1).collect();
            let p_odd_str = format!("{}{}", s_i, suffix_rev_odd);
            if let Ok(p_odd) = p_odd_str.parse::<i64>() {
                if Self::is_palindrome_base_k(p_odd, k) {
                    k_mirror_numbers.insert(p_odd);
                }
            }

            // Generate even length palindrome from 'i'
            let suffix_rev_even: String = s_i.chars().rev().collect();
            let p_even_str = format!("{}{}", s_i, suffix_rev_even);
            if let Ok(p_even) = p_even_str.parse::<i64>() {
                if Self::is_palindrome_base_k(p_even, k) {
                    k_mirror_numbers.insert(p_even);
                }
            }

            i += 1;
            if i > 1_000_000 { 
                break;
            }
        }

        k_mirror_numbers.into_iter().take(n as usize).sum()
    }
}