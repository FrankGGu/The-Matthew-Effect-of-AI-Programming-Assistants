impl Solution {
    pub fn minimum_changes(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut changes = 0;

        for i in (0..n).step_by(3) {
            if s_bytes[i] != b'1' {
                changes += 1;
            }
            if s_bytes[i + 1] != b'0' {
                changes += 1;
            }
            if s_bytes[i + 2] != b'1' {
                changes += 1;
            }
        }
        changes
    }
}