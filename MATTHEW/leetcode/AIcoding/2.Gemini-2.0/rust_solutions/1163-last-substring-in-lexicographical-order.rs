impl Solution {
    pub fn last_substring(s: String) -> String {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mut j = 1;
        let mut k = 0;
        let mut i = 0;

        while j + k < n {
            if s_bytes[i + k] == s_bytes[j + k] {
                k += 1;
            } else if s_bytes[i + k] > s_bytes[j + k] {
                j = j + k + 1;
                k = 0;
            } else {
                i = std::cmp::max(i + k + 1, j);
                j = i + 1;
                k = 0;
            }
        }
        s[i..].to_string()
    }
}