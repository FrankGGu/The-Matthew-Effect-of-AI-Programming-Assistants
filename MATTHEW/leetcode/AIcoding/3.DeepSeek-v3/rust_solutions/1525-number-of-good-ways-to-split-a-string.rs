use std::collections::HashSet;

impl Solution {
    pub fn num_splits(s: String) -> i32 {
        let mut left_counts = vec![0; s.len()];
        let mut right_counts = vec![0; s.len()];
        let mut left_set = HashSet::new();
        let mut right_set = HashSet::new();
        let chars: Vec<char> = s.chars().collect();

        for i in 0..chars.len() {
            left_set.insert(chars[i]);
            left_counts[i] = left_set.len();
        }

        for i in (0..chars.len()).rev() {
            right_set.insert(chars[i]);
            right_counts[i] = right_set.len();
        }

        let mut good_splits = 0;
        for i in 0..chars.len() - 1 {
            if left_counts[i] == right_counts[i + 1] {
                good_splits += 1;
            }
        }

        good_splits
    }
}