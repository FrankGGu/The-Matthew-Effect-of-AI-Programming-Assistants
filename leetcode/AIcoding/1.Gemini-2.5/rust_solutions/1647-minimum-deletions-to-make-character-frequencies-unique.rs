use std::collections::HashSet;

impl Solution {
    pub fn min_deletions(s: String) -> i32 {
        let mut freq = vec![0; 26];
        for c in s.chars() {
            freq[(c as u8 - b'a') as usize] += 1;
        }

        let mut deletions = 0;
        let mut seen_freqs: HashSet<i32> = HashSet::new();

        for &f in freq.iter() {
            let mut current_f = f;
            while current_f > 0 && seen_freqs.contains(&current_f) {
                current_f -= 1;
                deletions += 1;
            }
            if current_f > 0 {
                seen_freqs.insert(current_f);
            }
        }

        deletions
    }
}