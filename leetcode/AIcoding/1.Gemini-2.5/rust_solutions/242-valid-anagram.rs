impl Solution {
    pub fn is_anagram(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let mut counts = [0; 26];

        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        for c in t.chars() {
            counts[(c as u8 - b'a') as usize] -= 1;
        }

        for count in counts.iter() {
            if *count != 0 {
                return false;
            }
        }

        true
    }
}