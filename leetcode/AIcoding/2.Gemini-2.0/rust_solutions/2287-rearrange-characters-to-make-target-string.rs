use std::collections::HashMap;

impl Solution {
    pub fn rearrange_characters(s: String, target: String) -> i32 {
        let mut s_counts: HashMap<char, i32> = HashMap::new();
        let mut target_counts: HashMap<char, i32> = HashMap::new();

        for c in s.chars() {
            *s_counts.entry(c).or_insert(0) += 1;
        }

        for c in target.chars() {
            *target_counts.entry(c).or_insert(0) += 1;
        }

        let mut min_rearrangements = i32::MAX;
        for (c, count) in &target_counts {
            if !s_counts.contains_key(c) {
                return 0;
            }
            let s_count = s_counts.get(c).unwrap();
            min_rearrangements = min_rearrangements.min(s_count / count);
        }

        min_rearrangements
    }
}