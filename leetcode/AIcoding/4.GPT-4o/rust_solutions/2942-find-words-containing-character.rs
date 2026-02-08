impl Solution {
    pub fn word_subsets(words1: Vec<String>, words2: Vec<String>) -> Vec<String> {
        use std::collections::HashMap;
        let mut max_count = vec![0; 26];

        for word in words2.iter() {
            let mut count = vec![0; 26];
            for c in word.chars() {
                count[(c as usize - 'a' as usize)] += 1;
            }
            for i in 0..26 {
                max_count[i] = max_count[i].max(count[i]);
            }
        }

        let mut result = Vec::new();
        for word in words1.iter() {
            let mut count = vec![0; 26];
            for c in word.chars() {
                count[(c as usize - 'a' as usize)] += 1;
            }
            if (0..26).all(|i| count[i] >= max_count[i]) {
                result.push(word.clone());
            }
        }

        result
    }
}