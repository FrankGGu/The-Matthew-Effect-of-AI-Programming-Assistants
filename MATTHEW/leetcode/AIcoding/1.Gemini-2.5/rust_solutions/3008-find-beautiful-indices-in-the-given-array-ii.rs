impl Solution {
    pub fn find_beautiful_indices(s: String, a: String, b: String, k: i32) -> i64 {
        let s_bytes = s.as_bytes();
        let a_bytes = a.as_bytes();
        let b_bytes = b.as_bytes();
        let k_isize = k as isize;

        let lps_a = Self::compute_lps(a_bytes);
        let indices_a = Self::kmp_search(s_bytes, a_bytes, &lps_a);

        let lps_b = Self::compute_lps(b_bytes);
        let indices_b = Self::kmp_search(s_bytes, b_bytes, &lps_b);

        let mut ans = 0;
        let mut left = 0; // Pointer for the start of the valid window in indices_b
        let mut right = 0; // Pointer for the end of the valid window in indices_b

        for &i in indices_a.iter() {
            let i_isize = i as isize;
            let lower_bound = i_isize - k_isize;
            let upper_bound = i_isize + k_isize;

            // Advance 'left' pointer to the first index j such that j >= lower_bound
            while left < indices_b.len() && (indices_b[left] as isize) < lower_bound {
                left += 1;
            }

            // Ensure 'right' pointer is not behind 'left'
            right = right.max(left);

            // Advance 'right' pointer to the first index j such that j > upper_bound
            while right < indices_b.len() && (indices_b[right] as isize) <= upper_bound {
                right += 1;
            }

            ans += (right - left) as i64;
        }

        ans
    }

    // KMP helper function to compute the Longest Proper Prefix which is also a Suffix (LPS) array
    fn compute_lps(pattern: &[u8]) -> Vec<usize> {
        let m = pattern.len();
        let mut lps = vec![0; m];
        let mut length = 0; // length of the previous longest prefix suffix
        let mut i = 1;
        while i < m {
            if pattern[i] == pattern[length] {
                length += 1;
                lps[i] = length;
                i += 1;
            } else {
                if length != 0 {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i += 1;
                }
            }
        }
        lps
    }

    // KMP helper function to search for all occurrences of a pattern in text
    fn kmp_search(text: &[u8], pattern: &[u8], lps: &[usize]) -> Vec<usize> {
        let n = text.len();
        let m = pattern.len();
        let mut occurrences = Vec::new();

        if m == 0 || n < m {
            return occurrences;
        }

        let mut i = 0; // index for text
        let mut j = 0; // index for pattern
        while i < n {
            if pattern[j] == text[i] {
                i += 1;
                j += 1;
            }
            if j == m {
                occurrences.push(i - j);
                j = lps[j - 1];
            } else if i < n && pattern[j] != text[i] {
                if j != 0 {
                    j = lps[j - 1];
                } else {
                    i += 1;
                }
            }
        }
        occurrences
    }
}