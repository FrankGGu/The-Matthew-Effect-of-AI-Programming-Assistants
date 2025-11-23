impl Solution {
    pub fn word_subsets(words1: Vec<String>, words2: Vec<String>) -> Vec<String> {
        let mut bmax = vec![0; 26];
        for word in &words2 {
            let mut freq = vec![0; 26];
            for &byte in word.as_bytes() {
                freq[(byte - b'a') as usize] += 1;
            }
            for i in 0..26 {
                bmax[i] = bmax[i].max(freq[i]);
            }
        }

        let mut result = Vec::new();
        for word in &words1 {
            let mut freq = vec![0; 26];
            for &byte in word.as_bytes() {
                freq[(byte - b'a') as usize] += 1;
            }
            let mut universal = true;
            for i in 0..26 {
                if freq[i] < bmax[i] {
                    universal = false;
                    break;
                }
            }
            if universal {
                result.push(word.clone());
            }
        }

        result
    }
}