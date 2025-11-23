impl Solution {
    pub fn count_key_changes(s: String) -> i32 {
        if s.len() <= 1 {
            return 0;
        }

        let mut changes = 0;
        let mut chars = s.chars();
        let mut prev_char = chars.next().unwrap().to_ascii_lowercase();

        for current_char in chars {
            let lower_current_char = current_char.to_ascii_lowercase();
            if lower_current_char != prev_char {
                changes += 1;
            }
            prev_char = lower_current_char;
        }

        changes
    }
}