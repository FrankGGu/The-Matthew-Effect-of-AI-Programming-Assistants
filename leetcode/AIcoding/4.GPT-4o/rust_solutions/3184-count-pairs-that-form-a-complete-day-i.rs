use std::collections::HashMap;

pub fn count_pairs(dates: Vec<i32>) -> i32 {
    let mut count = 0;
    let mut map = HashMap::new();

    for &date in &dates {
        count += map.get(&(date - 1)).unwrap_or(&0);
        *map.entry(date).or_insert(0) += 1;
    }

    count
}