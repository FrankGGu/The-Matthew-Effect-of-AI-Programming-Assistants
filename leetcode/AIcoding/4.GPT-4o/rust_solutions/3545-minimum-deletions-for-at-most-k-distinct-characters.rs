impl Solution {
    pub fn minimum_deletions(s: String, k: i32) -> i32 {
        use std::collections::HashMap;

        let mut char_count = HashMap::new();
        for ch in s.chars() {
            *char_count.entry(ch).or_insert(0) += 1;
        }

        let mut freq: Vec<i32> = char_count.values().cloned().collect();
        freq.sort_unstable_by(|a, b| b.cmp(a));

        let n = freq.len();
        if n <= k {
            return 0;
        }

        let to_delete = n - k;
        freq.sort_unstable();
        freq.iter().take(to_delete).sum()
    }
}