use std::collections::HashMap;

pub fn largest_values_from_labels(values: Vec<i32>, labels: Vec<i32>, num_wanted: i32, use_limit: i32) -> i32 {
    let mut value_label_pairs: Vec<(i32, i32)> = values.into_iter().zip(labels.into_iter()).collect();
    value_label_pairs.sort_unstable_by(|a, b| b.0.cmp(&a.0));

    let mut label_count: HashMap<i32, i32> = HashMap::new();
    let mut total = 0;
    let mut count = 0;

    for (value, label) in value_label_pairs.iter() {
        if count < num_wanted {
            let entry = label_count.entry(*label).or_insert(0);
            if *entry < use_limit {
                total += value;
                *entry += 1;
                count += 1;
            }
        } else {
            break;
        }
    }

    total
}