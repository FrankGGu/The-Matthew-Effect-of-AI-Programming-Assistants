use std::collections::HashMap;

pub fn unique_occurrences(arr: Vec<i32>) -> bool {
    let mut count_map = HashMap::new();
    for &num in &arr {
        *count_map.entry(num).or_insert(0) += 1;
    }

    let mut occurrences = HashMap::new();
    for &count in count_map.values() {
        *occurrences.entry(count).or_insert(0) += 1;
    }

    occurrences.len() == count_map.len()
}