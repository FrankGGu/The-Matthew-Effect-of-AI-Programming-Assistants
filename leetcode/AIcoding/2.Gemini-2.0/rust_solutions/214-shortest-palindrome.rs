impl Solution {
    pub fn shortest_palindrome(s: String) -> String {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut lps = vec![0; n];
        let mut len = 0;
        let mut i = 1;
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

        let mut s_rev = s.chars().rev().collect::<String>();
        let combined = s.clone() + "#" + &s_rev;
        let combined_bytes = combined.as_bytes();
        let combined_len = combined.len();
        let mut lps_combined = vec![0; combined_len];
        len = 0;
        i = 1;
        while i < combined_len {
            if combined_bytes[i] == combined_bytes[len] {
                len += 1;
                lps_combined[i] = len;
                i += 1;
            } else {
                if len != 0 {
                    len = lps_combined[len - 1];
                } else {
                    lps_combined[i] = 0;
                    i += 1;
                }
            }
        }

        let prefix_len = lps_combined[combined_len - 1];
        let suffix = s_bytes[prefix_len..].iter().rev().map(|&b| b as char).collect::<String>();

        suffix + &s
    }
}