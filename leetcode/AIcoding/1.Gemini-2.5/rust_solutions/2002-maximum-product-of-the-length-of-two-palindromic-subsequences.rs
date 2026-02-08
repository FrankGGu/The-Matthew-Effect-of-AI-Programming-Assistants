impl Solution {
    fn is_palindrome(s_chars: &[char]) -> bool {
        let n = s_chars.len();
        if n == 0 {
            return true;
        }
        let mut left = 0;
        let mut right = n - 1;
        while left < right {
            if s_chars[left] != s_chars[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }

    pub fn max_product(s: String) -> i32 {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();

        let mut palindrome_lengths: Vec<i32> = vec![0; 1 << n];

        for mask in 1..(1 << n) {
            let mut current_subsequence_chars: Vec<char> = Vec::new();
            for i in 0..n {
                if (mask >> i) & 1 == 1 {
                    current_subsequence_chars.push(s_chars[i]);
                }
            }

            if Self::is_palindrome(&current_subsequence_chars) {
                palindrome_lengths[mask] = current_subsequence_chars.len() as i32;
            }
        }

        let mut max_prod = 0;

        for mask1 in 1..(1 << n) {
            if palindrome_lengths[mask1] == 0 {
                continue;
            }
            for mask2 in (mask1 + 1)..(1 << n) {
                if palindrome_lengths[mask2] == 0 {
                    continue;
                }
                if (mask1 & mask2) == 0 {
                    max_prod = max_prod.max(palindrome_lengths[mask1] * palindrome_lengths[mask2]);
                }
            }
        }

        max_prod
    }
}