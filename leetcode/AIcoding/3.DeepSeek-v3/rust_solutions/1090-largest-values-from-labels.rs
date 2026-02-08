use std::collections::HashMap;

impl Solution {
    pub fn largest_vals_from_labels(values: Vec<i32>, labels: Vec<i32>, num_wanted: i32, use_limit: i32) -> i32 {
        let mut items: Vec<(i32, i32)> = values.into_iter().zip(labels.into_iter()).collect();
        items.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut label_counts = HashMap::new();
        let mut total = 0;
        let mut count = 0;

        for (value, label) in items {
            if count >= num_wanted {
                break;
            }
            let entry = label_counts.entry(label).or_insert(0);
            if *entry < use_limit {
                *entry += 1;
                total += value;
                count += 1;
            }
        }

        total
    }
}