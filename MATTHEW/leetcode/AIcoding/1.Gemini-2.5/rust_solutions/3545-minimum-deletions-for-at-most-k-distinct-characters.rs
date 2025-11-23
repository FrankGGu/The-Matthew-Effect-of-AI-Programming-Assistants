use std::collections::HashMap;

impl Solution {
    pub fn minimum_deletions(s: String, k: i32) -> i32 {
        let mut counts = [0; 26];
        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut frequencies: Vec<i32> = counts.iter().filter(|&&count| count > 0).cloned().collect();
        frequencies.sort_unstable();

        let mut deletions = 0;
        let distinct_chars = frequencies.len() as i32;

        if distinct_chars <= k {
            return 0;
        }

        let num_to_eliminate = distinct_chars - k;

        for i in 0..num_to_eliminate as usize {
            deletions += frequencies[i];
        }

        deletions
    }
}