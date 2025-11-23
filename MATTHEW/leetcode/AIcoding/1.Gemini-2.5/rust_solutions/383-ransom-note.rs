impl Solution {
    pub fn can_construct(ransom_note: String, magazine: String) -> bool {
        let mut char_counts = [0; 26];

        for c in magazine.chars() {
            char_counts[(c as u8 - b'a') as usize] += 1;
        }

        for c in ransom_note.chars() {
            let index = (c as u8 - b'a') as usize;
            if char_counts[index] > 0 {
                char_counts[index] -= 1;
            } else {
                return false;
            }
        }

        true
    }
}