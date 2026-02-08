use std::collections::HashSet;

impl Solution {
    pub fn min_deletions(s: String) -> i32 {
        let mut freq_counts: [i32; 26] = [0; 26];

        for c in s.chars() {
            freq_counts[(c as usize - 'a' as usize)] += 1;
        }

        let mut non_zero_freqs: Vec<i32> = Vec::new();
        for count in freq_counts.iter() {
            if *count > 0 {
                non_zero_freqs.push(*count);
            }
        }

        non_zero_freqs.sort_by(|a, b| b.cmp(a));

        let mut operations = 0;
        let mut used_freqs: HashSet<i32> = HashSet::new();

        for mut current_freq in non_zero_freqs {
            while current_freq > 0 && used_freqs.contains(&current_freq) {
                current_freq -= 1;
                operations += 1;
            }
            if current_freq > 0 {
                used_freqs.insert(current_freq);
            }
        }

        operations
    }
}