use std::collections::HashMap;

pub fn most_frequent_ids(ids: Vec<i32>) -> Vec<i32> {
    let mut count = HashMap::new();
    for id in ids {
        *count.entry(id).or_insert(0) += 1;
    }

    let max_freq = count.values().cloned().max().unwrap_or(0);
    let mut result: Vec<i32> = count.iter()
        .filter(|&(_, &v)| v == max_freq)
        .map(|(&k, _)| k)
        .collect();

    result.sort();
    result
}