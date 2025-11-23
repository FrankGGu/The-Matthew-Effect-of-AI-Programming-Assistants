impl Solution {
    pub fn min_changes(s: String) -> i32 {
        let s = s.as_bytes();
        let mut changes = 0;
        for i in (0..s.len()).step_by(2) {
            if s[i] != s[i + 1] {
                changes += 1;
            }
        }
        changes
    }
}