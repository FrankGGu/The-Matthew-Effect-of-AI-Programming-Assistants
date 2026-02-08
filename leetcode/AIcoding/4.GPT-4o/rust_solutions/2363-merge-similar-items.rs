use std::collections::HashMap;

pub fn merge_similar_items(items1: Vec<Vec<i32>>, items2: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut map = HashMap::new();

    for item in items1 {
        map.insert(item[0], item[1]);
    }

    for item in items2 {
        let count = map.entry(item[0]).or_insert(0);
        *count += item[1];
    }

    let mut result: Vec<Vec<i32>> = map.into_iter().map(|(k, v)| vec![k, v]).collect();
    result.sort_by(|a, b| a[0].cmp(&b[0]));

    result
}