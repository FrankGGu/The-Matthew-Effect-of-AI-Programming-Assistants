impl Solution {
    pub fn shortest_completing_word(license_plate: String, words: Vec<String>) -> String {
        let mut count = [0; 26];
        let mut min_len = usize::MAX;
        let mut result = String::new();

        for ch in license_plate.chars() {
            if ch.is_alphabetic() {
                count[ch.to_ascii_lowercase() as usize - 'a' as usize] += 1;
            }
        }

        for word in words {
            let mut temp_count = count.clone();
            let mut valid = true;
            for ch in word.chars() {
                if ch.is_alphabetic() {
                    let idx = ch.to_ascii_lowercase() as usize - 'a' as usize;
                    temp_count[idx] -= 1;
                }
            }
            if temp_count.iter().all(|&c| c <= 0) {
                if word.len() < min_len {
                    min_len = word.len();
                    result = word;
                }
            }
        }
        result
    }
}