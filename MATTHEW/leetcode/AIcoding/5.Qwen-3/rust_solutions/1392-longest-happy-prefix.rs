struct Solution;

impl Solution {
    pub fn longest_happy_prefix(s: String) -> i32 {
        let n = s.len();
        let mut lps = vec![0; n];
        let mut length = 0;
        let s_bytes = s.as_bytes();

        for i in 1..n {
            while length > 0 && s_bytes[i] != s_bytes[length] {
                length = lps[length - 1];
            }

            if s_bytes[i] == s_bytes[length] {
                length += 1;
                lps[i] = length as i32;
            } else {
                lps[i] = 0;
            }
        }

        *lps.last().unwrap()
    }
}