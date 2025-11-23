impl Solution {
    pub fn num_smaller_by_frequency(queries: Vec<String>, words: Vec<String>) -> Vec<i32> {
        let mut word_freqs: Vec<i32> = words.iter().map(|word| Self::f(word)).collect();
        word_freqs.sort();
        let mut result: Vec<i32> = Vec::new();

        for query in queries {
            let query_freq = Self::f(&query);
            let mut count = 0;
            for &freq in &word_freqs {
                if freq > query_freq {
                    count += 1;
                }
            }
            result.push(count);
        }

        result
    }

    fn f(s: &str) -> i32 {
        let mut counts = [0; 26];
        for &byte in s.as_bytes() {
            counts[(byte - b'a') as usize] += 1;
        }
        for &count in &counts {
            if count > 0 {
                return count;
            }
        }
        0
    }
}