use std::collections::HashMap;

impl Solution {
    pub fn num_smaller_by_frequency(queries: Vec<String>, words: Vec<String>) -> Vec<i32> {
        fn frequency(s: &str) -> i32 {
            let mut count = [0; 26];
            for ch in s.chars() {
                count[(ch as usize - 'a' as usize)] += 1;
            }
            let min_freq = count.iter().filter(|&&x| x > 0).min().unwrap();
            *min_freq
        }

        let word_freqs: Vec<i32> = words.iter().map(|w| frequency(w)).collect();
        let mut freq_count = vec![0; 11];

        for &f in &word_freqs {
            freq_count[f as usize] += 1;
        }

        for i in 1..freq_count.len() {
            freq_count[i] += freq_count[i - 1];
        }

        queries.iter().map(|q| {
            let f = frequency(q);
            if f >= freq_count.len() as i32 {
                0
            } else {
                freq_count[f as usize]
            }
        }).collect()
    }
}