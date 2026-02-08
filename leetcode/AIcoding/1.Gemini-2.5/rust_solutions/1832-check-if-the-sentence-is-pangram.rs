impl Solution {
    pub fn check_if_pangram(sentence: String) -> bool {
        let mut seen = [false; 26];
        for c in sentence.chars() {
            let index = (c as u8 - b'a') as usize;
            seen[index] = true;
        }
        seen.iter().all(|&x| x)
    }
}