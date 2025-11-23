use std::collections::HashMap;

impl Solution {
    pub fn min_number_of_booths(demand: Vec<String>) -> i32 {
        let mut max_counts: HashMap<char, i32> = HashMap::new();

        for s in &demand {
            let mut current_counts: HashMap<char, i32> = HashMap::new();
            for c in s.chars() {
                *current_counts.entry(c).or_insert(0) += 1;
            }

            for (&c, &count) in &current_counts {
                let max_count = max_counts.entry(c).or_insert(0);
                *max_count = (*max_count).max(count);
            }
        }

        let mut total_booths = 0;
        for &count in max_counts.values() {
            total_booths += count;
        }

        total_booths
    }
}