impl Solution {
    pub fn to_goat_latin(sentence: String) -> String {
        let vowels: [char; 10] = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];
        let mut result_words: Vec<String> = Vec::new();

        for (i, word) in sentence.split_whitespace().enumerate() {
            let mut current_word = String::new();
            let first_char_option = word.chars().next();

            if let Some(first_char) = first_char_option {
                if vowels.contains(&first_char) {
                    current_word.push_str(word);
                    current_word.push_str("ma");
                } else {
                    current_word.push_str(&word[first_char.len_utf8()..]);
                    current_word.push(first_char);
                    current_word.push_str("ma");
                }
            } else {
                // Handle empty word case, though split_whitespace usually avoids this for non-empty strings
                current_word.push_str("ma"); // Or just skip, depending on problem spec for empty words
            }

            for _ in 0..(i + 1) {
                current_word.push('a');
            }
            result_words.push(current_word);
        }

        result_words.join(" ")
    }
}