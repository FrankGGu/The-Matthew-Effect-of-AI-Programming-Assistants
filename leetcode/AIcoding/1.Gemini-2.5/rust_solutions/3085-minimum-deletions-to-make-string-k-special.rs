use std::collections::HashMap;

impl Solution {
    pub fn minimum_deletions(s: String, k: i32) -> i32 {
        let mut freq_map: HashMap<char, i32> = HashMap::new();
        for c in s.chars() {
            *freq_map.entry(c).or_insert(0) += 1;
        }

        let mut freqs: Vec<i32> = freq_map.values().cloned().collect();
        // Sorting frequencies is not strictly necessary for correctness but can help
        // if we were to optimize the inner loop, and makes reasoning slightly clearer.
        // For 26 elements, its cost is negligible.
        freqs.sort_unstable();

        let mut min_deletions = s.len() as i32; // Initialize with max possible deletions (delete all)

        // The minimum frequency (min_f) can range from 0 up to the maximum frequency
        // observed in the string. If min_f goes higher, it will only result in more
        // deletions or the same as deleting all characters.
        let max_freq_val = *freqs.last().unwrap_or(&0);

        for min_f in 0..=max_freq_val {
            let mut current_deletions = 0;
            let upper_bound = min_f + k;

            for &f in &freqs {
                if f < min_f {
                    // Frequency is too low, delete all occurrences of this character
                    current_deletions += f;
                } else if f > upper_bound {
                    // Frequency is too high, reduce it to upper_bound
                    current_deletions += f - upper_bound;
                }
                // If min_f <= f <= upper_bound, no deletions needed for this character
            }
            min_deletions = min_deletions.min(current_deletions);
        }

        min_deletions
    }
}