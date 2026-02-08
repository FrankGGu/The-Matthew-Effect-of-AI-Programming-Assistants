use std::collections::HashMap;

impl Solution {
    pub fn minimum_operations_to_make_k_periodic(word: String, k: i32) -> i32 {
        let k = k as usize;
        let mut freq = HashMap::new();
        let chunks = word.chars().collect::<Vec<_>>();
        let n = chunks.len();
        let mut max_freq = 0;

        for i in (0..n).step_by(k) {
            if i + k > n {
                break;
            }
            let chunk = &chunks[i..i + k];
            *freq.entry(chunk).or_insert(0) += 1;
            max_freq = max_freq.max(freq[chunk]);
        }

        (n / k - max_freq) as i32
    }
}