impl Solution {
    pub fn find_original_string(s: String) -> String {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut lps = vec![0; n];
        let mut i = 1;
        let mut len = 0;

        while i < n {
            if s_bytes[i] == s_bytes[len] {
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

        let len = lps[n - 1];
        if n % (n - len) == 0 {
            String::from_utf8(s_bytes[..n - len].to_vec()).unwrap()
        } else {
            s
        }
    }
}