impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn are_sentences_similar(sentence1: String, sentence2: String) -> bool {
        let words1: Vec<&str> = sentence1.split_whitespace().collect();
        let words2: Vec<&str> = sentence2.split_whitespace().collect();

        if words1.len() == words2.len() {
            return words1 == words2;
        }

        let (longer, shorter) = if words1.len() > words2.len() {
            (&words1, &words2)
        } else {
            (&words2, &words1)
        };

        let mut i = 0;
        while i < shorter.len() && longer[i] == shorter[i] {
            i += 1;
        }

        let mut j = 0;
        while j < shorter.len() && longer[longer.len() - shorter.len() + j] == shorter[shorter.len() - shorter.len() + j] {
            j += 1;
        }

        return i + j >= shorter.len();
    }
}
}