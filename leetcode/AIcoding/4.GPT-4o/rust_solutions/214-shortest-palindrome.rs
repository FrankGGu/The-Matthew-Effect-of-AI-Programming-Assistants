impl Solution {
    pub fn shortest_palindrome(s: String) -> String {
        let rev_s: String = s.chars().rev().collect();
        let l = s.len();
        let mut kmp = vec![0; l];
        let mut j = 0;

        for i in 1..l {
            while j > 0 && s.chars().nth(i) != s.chars().nth(j) {
                j = kmp[j - 1];
            }
            if s.chars().nth(i) == s.chars().nth(j) {
                j += 1;
                kmp[i] = j;
            }
        }

        let max_pal_len = kmp[l - 1];
        let suffix = &rev_s[..l - max_pal_len];
        format!("{}{}", suffix, s)
    }
}