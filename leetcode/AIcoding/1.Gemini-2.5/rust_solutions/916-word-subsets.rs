impl Solution {
    pub fn word_subsets(words1: Vec<String>, words2: Vec<String>) -> Vec<String> {
        let mut max_b_counts = [0; 26];

        for b_word in &words2 {
            let b_counts = Self::count_chars(b_word);
            for i in 0..26 {
                max_b_counts[i] = max_b_counts[i].max(b_counts[i]);
            }
        }

        let mut result = Vec::new();

        for a_word in words1 {
            let a_counts = Self::count_chars(&a_word);
            let mut is_universal = true;
            for i in 0..26 {
                if a_counts[i] < max_b_counts[i] {
                    is_universal = false;
                    break;
                }
            }
            if is_universal {
                result.push(a_word);
            }
        }

        result
    }

    fn count_chars(word: &str) -> [u8; 26] {
        let mut counts = [0; 26];
        for c in word.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }
        counts
    }
}