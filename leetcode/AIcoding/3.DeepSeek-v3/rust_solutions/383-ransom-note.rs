use std::collections::HashMap;

impl Solution {
    pub fn can_construct(ransom_note: String, magazine: String) -> bool {
        let mut counts = HashMap::new();
        for c in magazine.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }
        for c in ransom_note.chars() {
            let count = counts.entry(c).or_insert(0);
            if *count == 0 {
                return false;
            }
            *count -= 1;
        }
        true
    }
}