impl Solution {
    pub fn common_chars(words: Vec<String>) -> Vec<String> {
        if words.is_empty() {
            return Vec::new();
        }

        let mut min_freq = [0; 26];

        // Initialize min_freq with the frequencies of the first word
        for c in words[0].chars() {
            min_freq[c as usize - 'a' as usize] += 1;
        }

        // Iterate through the remaining words
        for i in 1..words.len() {
            let mut current_word_freq = [0; 26];
            for c in words[i].chars() {
                current_word_freq[c as usize - 'a' as usize] += 1;
            }

            // Update min_freq by taking the minimum count for each character
            for j in 0..26 {
                min_freq[j] = min_freq[j].min(current_word_freq[j]);
            }
        }

        // Construct the result vector
        let mut result = Vec::new();
        for i in 0..26 {
            let char_code = (b'a' + i as u8) as char;
            for _ in 0..min_freq[i] {
                result.push(char_code.to_string());
            }
        }

        result
    }
}