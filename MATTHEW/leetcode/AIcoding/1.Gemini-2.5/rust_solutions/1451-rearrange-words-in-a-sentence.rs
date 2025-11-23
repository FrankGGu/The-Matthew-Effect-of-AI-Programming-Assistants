impl Solution {
    pub fn arrange_words(text: String) -> String {
        let mut words_data: Vec<(String, usize, usize)> = text
            .split_whitespace()
            .enumerate()
            .map(|(index, word)| {
                (word.to_lowercase(), index, word.len())
            })
            .collect();

        words_data.sort_by(|a, b| {
            if a.2 != b.2 {
                a.2.cmp(&b.2)
            } else {
                a.1.cmp(&b.1)
            }
        });

        let mut result_words: Vec<String> = words_data
            .into_iter()
            .map(|(word, _, _)| word)
            .collect();

        if let Some(first_word) = result_words.get_mut(0) {
            if !first_word.is_empty() {
                let mut chars = first_word.chars();
                if let Some(first_char) = chars.next() {
                    let capitalized_first_char = first_char.to_ascii_uppercase().to_string();
                    *first_word = capitalized_first_char + chars.as_str();
                }
            }
        }

        result_words.join(" ")
    }
}