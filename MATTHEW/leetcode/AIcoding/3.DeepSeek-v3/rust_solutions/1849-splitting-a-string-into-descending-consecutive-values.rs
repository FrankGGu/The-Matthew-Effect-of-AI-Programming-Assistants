impl Solution {
    pub fn split_string(s: String) -> bool {
        let s = s.as_bytes();
        let n = s.len();
        for i in 1..=n / 2 + 1 {
            if Self::dfs(&s, 0, None, i) {
                return true;
            }
        }
        false
    }

    fn dfs(s: &[u8], start: usize, prev: Option<u64>, len: usize) -> bool {
        if start + len > s.len() {
            return false;
        }
        let num_str = &s[start..start + len];
        let num = String::from_utf8_lossy(num_str).parse::<u64>().unwrap();
        if let Some(p) = prev {
            if p != num + 1 {
                return false;
            }
            if start + len == s.len() {
                return true;
            }
        }
        for l in 1..=(s.len() - start - len) {
            if Self::dfs(s, start + len, Some(num), l) {
                return true;
            }
        }
        false
    }
}