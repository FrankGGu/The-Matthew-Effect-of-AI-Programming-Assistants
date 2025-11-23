impl Solution {
    pub fn num_smaller_by_frequency(queries: Vec<String>, words: Vec<String>) -> Vec<i32> {
        let calculate_f = |s: &str| -> i32 {
            let mut min_char: char = '{'; 
            let mut count = 0;

            for c in s.chars() {
                if c < min_char {
                    min_char = c;
                    count = 1;
                } else if c == min_char {
                    count += 1;
                }
            }
            count
        };

        let mut word_frequencies: Vec<i32> = words.iter().map(|word| calculate_f(word)).collect();
        word_frequencies.sort_unstable();

        let mut results: Vec<i32> = Vec::with_capacity(queries.len());
        for query in queries.iter() {
            let query_freq = calculate_f(query);
            let idx = word_frequencies.partition_point(|&x| x <= query_freq);
            results.push((word_frequencies.len() - idx) as i32);
        }

        results
    }
}