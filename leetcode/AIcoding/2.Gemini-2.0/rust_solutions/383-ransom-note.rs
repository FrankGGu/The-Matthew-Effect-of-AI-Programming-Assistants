impl Solution {
    pub fn can_construct(ransom_note: String, magazine: String) -> bool {
        let mut magazine_counts = std::collections::HashMap::new();

        for c in magazine.chars() {
            *magazine_counts.entry(c).or_insert(0) += 1;
        }

        for c in ransom_note.chars() {
            match magazine_counts.get_mut(&c) {
                Some(count) => {
                    if *count == 0 {
                        return false;
                    }
                    *count -= 1;
                }
                None => return false,
            }
        }

        true
    }
}