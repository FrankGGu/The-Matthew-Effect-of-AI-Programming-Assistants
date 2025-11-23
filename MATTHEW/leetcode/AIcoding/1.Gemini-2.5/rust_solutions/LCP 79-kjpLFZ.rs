impl Solution {
    pub fn is_subsequence(s: String, t: String) -> bool {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        let mut i = 0; // pointer for s
        let mut j = 0; // pointer for t

        while i < s_bytes.len() && j < t_bytes.len() {
            if s_bytes[i] == t_bytes[j] {
                j += 1;
            }
            i += 1;
        }

        j == t_bytes.len()
    }
}