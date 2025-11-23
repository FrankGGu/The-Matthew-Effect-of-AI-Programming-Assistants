impl Solution {
    pub fn shortest_completing_word(license_plate: String, words: Vec<String>) -> String {
        let mut license_plate_counts = [0; 26];
        for c in license_plate.chars() {
            if c.is_ascii_alphabetic() {
                license_plate_counts[(c.to_ascii_lowercase() as u8 - b'a') as usize] += 1;
            }
        }

        let mut shortest_word_index = 0;
        let mut min_len = usize::MAX;

        for (i, word) in words.iter().enumerate() {
            let mut word_counts = [0; 26];
            for c in word.chars() {
                word_counts[(c as u8 - b'a') as usize] += 1;
            }

            let mut completes = true;
            for j in 0..26 {
                if word_counts[j] < license_plate_counts[j] {
                    completes = false;
                    break;
                }
            }

            if completes {
                if word.len() < min_len {
                    min_len = word.len();
                    shortest_word_index = i;
                }
            }
        }

        words[shortest_word_index].clone()
    }
}