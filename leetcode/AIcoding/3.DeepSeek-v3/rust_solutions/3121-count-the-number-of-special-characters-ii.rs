impl Solution {
    pub fn number_of_special_chars(word: String) -> i32 {
        let mut lower = [false; 26];
        let mut upper = [false; 26];
        let mut special = [false; 26];

        for c in word.chars() {
            if c.is_ascii_lowercase() {
                let idx = (c as u8 - b'a') as usize;
                lower[idx] = true;
                if upper[idx] {
                    special[idx] = true;
                }
            } else if c.is_ascii_uppercase() {
                let idx = (c as u8 - b'A') as usize;
                upper[idx] = true;
                if lower[idx] {
                    special[idx] = true;
                }
            }
        }

        special.iter().filter(|&&x| x).count() as i32
    }
}