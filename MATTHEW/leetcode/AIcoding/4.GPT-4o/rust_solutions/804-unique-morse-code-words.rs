impl Solution {
    pub fn unique_morse_representations(words: Vec<String>) -> i32 {
        let morse_code: Vec<&str> = vec![
            ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---",
            "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-",
            "..-", "...-", ".--", "-..-", "-.--", "--..",
        ];

        let mut transformations = std::collections::HashSet::new();

        for word in words {
            let mut morse_word = String::new();
            for c in word.chars() {
                morse_word.push_str(morse_code[c as usize - 'a' as usize]);
            }
            transformations.insert(morse_word);
        }

        transformations.len() as i32
    }
}