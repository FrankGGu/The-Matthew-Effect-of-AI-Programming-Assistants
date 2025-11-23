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
            } else if s[i + k] > s[j + k] {
                j = j + k + 1;
            } else {
                i = std::cmp::max(i + k + 1, j);
                j = i + 1;
            }
            k = 0;
        }
        String::from_utf8(s[i..].to_vec()).unwrap()
    }
}