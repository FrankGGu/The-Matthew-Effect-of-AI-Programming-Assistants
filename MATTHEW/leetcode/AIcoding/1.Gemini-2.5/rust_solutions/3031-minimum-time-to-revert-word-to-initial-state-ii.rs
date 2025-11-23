impl Solution {
    pub fn minimum_time_to_revert_word_to_initial_state(word: String, k: i32) -> i32 {
        let n = word.len();
        let k = k as usize;
        let s_bytes = word.as_bytes();

        let lps = Self::compute_lps(s_bytes);

        // The length of the longest proper prefix of `word` that is also a suffix of `word`.
        let len_of_border = lps[n - 1];

        // The candidate for the smallest period of `word`.
        // If `n` is a multiple of `n - len_of_border`, then `n - len_of_border` is the smallest period.
        // Otherwise, the smallest period is `n` itself.
        let period_candidate = n - len_of_border;

        let p = if n % period_candidate == 0 {
            period_candidate
        } else {
            n
        };

        // We need to find the minimum number of operations `i` such that `i * k` is a multiple of `p`.
        // This is equivalent to finding the smallest `i >= 1` such that `i * k = m * p` for some integer `m >= 1`.
        // The smallest such `i` is `p / gcd(p, k)`.
        let common_divisor = Self::gcd(p, k);
        (p / common_divisor) as i32
    }

    // Computes the Longest Proper Prefix which is also a Suffix (LPS) array for a given string.
    // This is a core component of the KMP algorithm.
    fn compute_lps(s: &[u8]) -> Vec<usize> {
        let n = s.len();
        let mut lps = vec![0; n];
        let mut length = 0; // Length of the previous longest prefix suffix

        let mut i = 1;
        while i < n {
            if s[i] == s[length] {
                length += 1;
                lps[i] = length;
                i += 1;
            } else {
                if length != 0 {
                    // Mismatch after `length` characters.
                    // Fall back to the LPS value of the previous prefix.
                    length = lps[length - 1];
                } else {
                    // No prefix matches. LPS is 0.
                    lps[i] = 0;
                    i += 1;
                }
            }
        }
        lps
    }

    // Computes the greatest common divisor (GCD) of two numbers using the Euclidean algorithm.
    fn gcd(a: usize, b: usize) -> usize {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}