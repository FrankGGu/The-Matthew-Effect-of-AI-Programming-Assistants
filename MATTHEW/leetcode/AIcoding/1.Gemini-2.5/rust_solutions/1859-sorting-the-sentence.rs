impl Solution {
    pub fn sort_sentence(s: String) -> String {
        let words_iter = s.split_whitespace();
        let num_words = words_iter.clone().count();

        let mut result_words: Vec<String> = vec![String::new(); num_words];

        for word_with_pos in words_iter {
            let len = word_with_pos.len();
            let pos_char = word_with_pos.chars().last().unwrap();
            let pos = pos_char.to_digit(10).unwrap() as usize;

            let actual_word = &word_with_pos[0..len - 1];

            result_words[pos - 1] = actual_word.to_string();
        }

        result_words.join(" ")
    }
}