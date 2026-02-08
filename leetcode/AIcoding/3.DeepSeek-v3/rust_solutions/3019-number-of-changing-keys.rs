impl Solution {
    pub fn count_key_changes(s: String) -> i32 {
        let s = s.to_lowercase();
        let mut changes = 0;
        let mut prev_char = s.chars().next().unwrap();

        for c in s.chars().skip(1) {
            if c != prev_char {
                changes += 1;
                prev_char = c;
            }
        }

        changes
    }
}