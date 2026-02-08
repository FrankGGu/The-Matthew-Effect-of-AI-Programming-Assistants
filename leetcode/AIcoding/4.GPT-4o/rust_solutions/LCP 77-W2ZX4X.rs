impl Solution {
    pub fn can_construct(ransom_note: String, magazine: String) -> bool {
        let mut counts = [0; 26];
        for ch in magazine.chars() {
            counts[(ch as usize - 'a' as usize)] += 1;
        }
        for ch in ransom_note.chars() {
            let index = (ch as usize - 'a' as usize);
            if counts[index] == 0 {
                return false;
            }
            counts[index] -= 1;
        }
        true
    }
}