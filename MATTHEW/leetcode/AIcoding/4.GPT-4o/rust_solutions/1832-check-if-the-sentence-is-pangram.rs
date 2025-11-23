impl Solution {
    pub fn check_if_pangram(sentence: String) -> bool {
        let mut alphabet = [false; 26];
        for c in sentence.chars() {
            if c.is_ascii_lowercase() {
                alphabet[(c as usize) - ('a' as usize)] = true;
            }
        }
        alphabet.iter().all(|&x| x)
    }
}