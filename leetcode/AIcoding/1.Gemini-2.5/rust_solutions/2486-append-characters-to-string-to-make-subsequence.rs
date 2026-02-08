impl Solution {
    pub fn append_characters(s: String, t: String) -> i32 {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        let mut s_ptr = 0;
        let mut t_ptr = 0;

        while s_ptr < s_bytes.len() && t_ptr < t_bytes.len() {
            if s_bytes[s_ptr] == t_bytes[t_ptr] {
                t_ptr += 1;
            }
            s_ptr += 1;
        }

        (t_bytes.len() - t_ptr) as i32
    }
}