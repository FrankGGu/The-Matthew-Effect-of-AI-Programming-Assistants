impl Solution {
    pub fn can_construct(ransom_note: String, magazine: String) -> bool {
        let mut count = std::collections::HashMap::new();
        for c in magazine.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        for c in ransom_note.chars() {
            if let Some(v) = count.get_mut(&c) {
                if *v == 0 {
                    return false;
                }
                *v -= 1;
            } else {
                return false;
            }
        }
        true
    }
}