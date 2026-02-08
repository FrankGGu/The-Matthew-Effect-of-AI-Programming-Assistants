use std::collections::HashMap;

impl Solution {
    pub fn largest_vals_from_labels(values: Vec<i32>, labels: Vec<i32>, num_wanted: i32, use_limit: i32) -> i32 {
        let n = values.len();
        let mut items: Vec<(i32, i32)> = Vec::with_capacity(n);

        for i in 0..n {
            items.push((values[i], labels[i]));
        }

        items.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut score = 0;
        let mut num_selected = 0;
        let mut label_counts: HashMap<i32, i32> = HashMap::new();

        for (value, label) in items {
            if num_selected == num_wanted {
                break;
            }

            let count = label_counts.entry(label).or_insert(0);
            if *count < use_limit {
                score += value;
                *count += 1;
                num_selected += 1;
            }
        }

        score
    }
}