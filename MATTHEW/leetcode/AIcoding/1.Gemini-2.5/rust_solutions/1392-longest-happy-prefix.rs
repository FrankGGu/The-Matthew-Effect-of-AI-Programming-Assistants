impl Solution {
    pub fn longest_happy_prefix(s: String) -> String {
        let n = s.len();
        if n == 0 {
            return String::new();
        }

        let s_bytes = s.as_bytes();
        let mut lps = vec![0; n];
        let mut length = 0;
        let mut i = 1;

        while i < n {
            if s_bytes[i] == s_bytes[length] {
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

        let result_len = lps[n - 1];
        s[0..result_len].to_string()
    }
}