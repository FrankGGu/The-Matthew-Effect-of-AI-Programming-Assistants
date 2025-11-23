use std::collections::HashSet;

impl Solution {
    pub fn unique_morse_representations(words: Vec<String>) -> i32 {
        let morse_codes = [
            ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."
        ];

        let mut unique_transformations: HashSet<String> = HashSet::new();

        for word in words {
            let mut current_transformation = String::new();
            for c in word.chars() {
                let index = (c as u8 - b'a') as usize;
                current_transformation.push_str(morse_codes[index]);
            }
            unique_transformations.insert(current_transformation);
        }

        unique_transformations.len() as i32
    }
}