use std::collections::HashSet;

impl Solution {
    pub fn unique_morse_representations(words: Vec<String>) -> i32 {
        let morse_codes = vec![
            ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..",
            "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-",
            "-.--", "--..",
        ];
        let mut transformations = HashSet::new();

        for word in words {
            let mut transformation = String::new();
            for c in word.chars() {
                let index = (c as u8 - b'a') as usize;
                transformation.push_str(morse_codes[index]);
            }
            transformations.insert(transformation);
        }

        transformations.len() as i32
    }
}