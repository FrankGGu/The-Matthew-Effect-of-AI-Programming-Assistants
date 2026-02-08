impl Solution {
    pub fn beautiful_indices(s: String, a: String, b: String, k: i32) -> Vec<i32> {
        let s_chars: Vec<char> = s.chars().collect();
        let a_chars: Vec<char> = a.chars().collect();
        let b_chars: Vec<char> = b.chars().collect();

        let a_indices = Self::kmp(&s_chars, &a_chars);
        let b_indices = Self::kmp(&s_chars, &b_chars);

        let mut res = Vec::new();
        let mut j = 0;
        let m = b_indices.len();

        for &i in &a_indices {
            while j < m && b_indices[j] < i - k {
                j += 1;
            }
            if j < m && b_indices[j] <= i + k {
                res.push(i as i32);
            }
        }

        res
    }

    fn kmp(text: &[char], pattern: &[char]) -> Vec<usize> {
        let n = text.len();
        let m = pattern.len();
        if m == 0 {
            return Vec::new();
        }

        let lps = Self::compute_lps(pattern);
        let mut res = Vec::new();
        let mut i = 0;
        let mut j = 0;

        while i < n {
            if text[i] == pattern[j] {
                i += 1;
                j += 1;
                if j == m {
                    res.push(i - j);
                    j = lps[j - 1];
                }
            } else {
                if j != 0 {
                    j = lps[j - 1];
                } else {
                    i += 1;
                }
            }
        }

        res
    }

    fn compute_lps(pattern: &[char]) -> Vec<usize> {
        let m = pattern.len();
        let mut lps = vec![0; m];
        let mut len = 0;
        let mut i = 1;

        while i < m {
            if pattern[i] == pattern[len] {
                len += 1;
                lps[i] = len;
                i += 1;
            } else {
                if len != 0 {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i += 1;
                }
            }
        }

        lps
    }
}