impl Solution {
    pub fn check_if_pangram(sentence: String) -> bool {
        let mut seen = [false; 26];
        for c in sentence.chars() {
            if c.is_ascii_lowercase() {
                seen[(c as u8 - b'a') as usize] = true;
            }
        }
        seen.iter().all(|&x| x)
    }
}