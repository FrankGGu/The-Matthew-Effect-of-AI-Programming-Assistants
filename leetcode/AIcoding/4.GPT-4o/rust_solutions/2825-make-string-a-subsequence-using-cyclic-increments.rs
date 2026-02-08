impl Solution {
    pub fn can_make_subsequence(s: String, t: String) -> bool {
        let mut s_bytes = s.into_bytes();
        let mut t_bytes = t.into_bytes();
        let mut j = 0;

        for i in 0..s_bytes.len() {
            if j < t_bytes.len() && (s_bytes[i] - b'a' + 1) % 26 == (t_bytes[j] - b'a') % 26 {
                j += 1;
            }
        }

        j == t_bytes.len()
    }
}