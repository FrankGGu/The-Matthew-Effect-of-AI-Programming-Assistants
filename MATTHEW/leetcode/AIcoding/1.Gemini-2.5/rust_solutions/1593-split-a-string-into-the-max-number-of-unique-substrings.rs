use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn max_unique_splits(s: String) -> i32 {
        let mut max_val = 0;
        let mut current_splits: HashSet<String> = HashSet::new();
        Self::backtrack(0, &s, &mut current_splits, &mut max_val);
        max_val
    }

    fn backtrack(
        start_index: usize,
        s: &str,
        current_splits: &mut HashSet<String>,
        max_val: &mut i32,
    ) {
        if start_index == s.len() {
            *max_val = (*max_val).max(current_splits.len() as i32);
            return;
        }

        for i in start_index..s.len() {
            let sub = &s[start_index..=i];

            if !current_splits.contains(sub) {
                current_splits.insert(sub.to_string());
                Self::backtrack(i + 1, s, current_splits, max_val);
                current_splits.remove(sub);
            }
        }
    }
}