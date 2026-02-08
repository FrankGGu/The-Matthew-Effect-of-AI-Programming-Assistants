impl Solution {
    pub fn most_words_found(sentences: Vec<String>) -> i32 {
        let mut max_words = 0;

        for sentence in sentences {
            let current_words = sentence.split(' ').count() as i32;
            if current_words > max_words {
                max_words = current_words;
            }
        }

        max_words
    }
}