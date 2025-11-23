use std::collections::HashMap;

impl Solution {
    pub fn minimum_operations_to_make_k_periodic(word: String, k: i32) -> i32 {
        let n = word.len();
        let k = k as usize;
        let word_chars: Vec<char> = word.chars().collect();

        let num_blocks = n / k;
        let mut total_operations = 0;

        for j in 0..k {
            let mut char_counts: HashMap<char, i32> = HashMap::new();
            let mut max_freq_in_column = 0;

            for i in 0..num_blocks {
                let char_at_pos = word_chars[j + i * k];
                *char_counts.entry(char_at_pos).or_insert(0) += 1;
                max_freq_in_column = max_freq_in_column.max(*char_counts.get(&char_at_pos).unwrap());
            }

            total_operations += num_blocks as i32 - max_freq_in_column;
        }

        total_operations
    }
}