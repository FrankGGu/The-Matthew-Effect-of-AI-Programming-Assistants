impl Solution {
    pub fn min_deletions(s: String, k: i32) -> i32 {
        let mut counts = std::collections::HashMap::new();
        for c in s.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        let mut freqs: Vec<i32> = counts.values().cloned().collect();
        freqs.sort_by(|a, b| b.cmp(a));

        let mut deletions = 0;
        let mut used = std::collections::HashSet::new();

        for freq in freqs {
            let mut current_freq = freq;
            while current_freq > 0 && used.contains(&current_freq) {
                current_freq -= 1;
                deletions += 1;
            }
            if current_freq > 0 {
                used.insert(current_freq);
            }
        }

        deletions
    }
}