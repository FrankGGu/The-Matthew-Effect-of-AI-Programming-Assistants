struct Solution;

impl Solution {
    pub fn last_substring(s: String) -> String {
        let s = s.as_bytes();
        let n = s.len();
        let mut i = 0;
        let mut j = 1;
        let mut k = 0;
        while j + k < n {
            if s[i + k] == s[j + k] {
                k += 1;
                continue;
            }
            if s[i + k] < s[j + k] {
                i = std::cmp::max(i + k + 1, j);
            } else {
                j = j + k + 1;
            }
            k = 0;
        }
        s[i..].to_vec().into_iter().map(|c| c as char).collect()
    }
}