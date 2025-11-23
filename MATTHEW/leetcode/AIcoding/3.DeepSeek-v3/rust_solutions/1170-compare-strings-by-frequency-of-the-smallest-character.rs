impl Solution {
    pub fn num_smaller_by_frequency(queries: Vec<String>, words: Vec<String>) -> Vec<i32> {
        let f = |s: &String| {
            let mut freq = [0; 26];
            for c in s.chars() {
                freq[(c as u8 - b'a') as usize] += 1;
            }
            for i in 0..26 {
                if freq[i] > 0 {
                    return freq[i];
                }
            }
            0
        };

        let mut word_freqs: Vec<i32> = words.iter().map(f).collect();
        word_freqs.sort_unstable();

        queries.iter().map(|query| {
            let q_freq = f(query);
            let idx = word_freqs.partition_point(|&x| x <= q_freq);
            (word_freqs.len() - idx) as i32
        }).collect()
    }
}