impl Solution {
    pub fn word_subsets(a: Vec<String>, b: Vec<String>) -> Vec<String> {
        let mut max_b_counts = [0; 26];
        for word in b {
            let mut word_counts = [0; 26];
            for c in word.chars() {
                let idx = (c as u8 - b'a') as usize;
                word_counts[idx] += 1;
            }
            for i in 0..26 {
                if word_counts[i] > max_b_counts[i] {
                    max_b_counts[i] = word_counts[i];
                }
            }
        }

        let mut result = Vec::new();
        for word in a {
            let mut word_counts = [0; 26];
            for c in word.chars() {
                let idx = (c as u8 - b'a') as usize;
                word_counts[idx] += 1;
            }
            let mut is_universal = true;
            for i in 0..26 {
                if word_counts[i] < max_b_counts[i] {
                    is_universal = false;
                    break;
                }
            }
            if is_universal {
                result.push(word);
            }
        }
        result
    }
}