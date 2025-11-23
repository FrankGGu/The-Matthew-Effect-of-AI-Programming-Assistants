struct Solution;

impl Solution {
    pub fn find_words(words: Vec<String>) -> Vec<String> {
        let mut row_map = [0; 26]; // 0 for Row 1, 1 for Row 2, 2 for Row 3

        // Populate row_map for Row 1: qwertyuiop
        for c in "qwertyuiop".chars() {
            row_map[(c as u8 - b'a') as usize] = 0;
        }
        // Populate row_map for Row 2: asdfghjkl
        for c in "asdfghjkl".chars() {
            row_map[(c as u8 - b'a') as usize] = 1;
        }
        // Populate row_map for Row 3: zxcvbnm
        for c in "zxcvbnm".chars() {
            row_map[(c as u8 - b'a') as usize] = 2;
        }

        let mut result = Vec::new();

        for word in words {
            if word.is_empty() {
                // According to constraints, words[i].length is between 1 and 100, so words are not empty.
                // If they could be empty, an empty word would technically be typable on any single row.
                continue;
            }

            let mut chars_iter = word.chars().map(|c| c.to_ascii_lowercase());

            // Get the row of the first character
            let first_char = chars_iter.next().unwrap();
            let target_row = row_map[(first_char as u8 - b'a') as usize];

            let mut all_same_row = true;
            for c in chars_iter {
                if row_map[(c as u8 - b'a') as usize] != target_row {
                    all_same_row = false;
                    break;
                }
            }

            if all_same_row {
                result.push(word);
            }
        }

        result
    }
}