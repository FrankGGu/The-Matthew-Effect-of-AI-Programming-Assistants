impl Solution {
    pub fn minimum_moves(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let mut count = 0;
        let mut i = 0;
        while i < s_bytes.len() {
            if s_bytes[i] == b'X' {
                count += 1;
                i += 3;
            } else {
                i += 1;
            }
        }
        count
    }
}