impl Solution {
    pub fn are_sentences_similar(sentence1: String, sentence2: String) -> bool {
        let words1: Vec<&str> = sentence1.split_whitespace().collect();
        let words2: Vec<&str> = sentence2.split_whitespace().collect();

        if words1.len() < words2.len() {
            return Self::are_sentences_similar_helper(&words2, &words1);
        }
        Self::are_sentences_similar_helper(&words1, &words2)
    }

    fn are_sentences_similar_helper(longer: &[&str], shorter: &[&str]) -> bool {
        let n = shorter.len();
        let mut i = 0;
        while i < n && longer[i] == shorter[i] {
            i += 1;
        }
        let mut j = 0;
        while j < n - i && longer[longer.len() - 1 - j] == shorter[shorter.len() - 1 - j] {
            j += 1;
        }
        i + j == n
    }
}