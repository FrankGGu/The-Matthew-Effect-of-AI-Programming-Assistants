use std::collections::HashMap;

impl Solution {
    pub fn merge_similar_items(items1: Vec<Vec<i32>>, items2: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut map: HashMap<i32, i32> = HashMap::new();

        for item in items1 {
            *map.entry(item[0]).or_insert(0) += item[1];
        }

        for item in items2 {
            *map.entry(item[0]).or_insert(0) += item[1];
        }

        let mut result: Vec<Vec<i32>> = map.into_iter().collect();
        result.sort_by(|a, b| a.0.cmp(&b.0));

        result.into_iter().map(|(a, b)| vec![a, b]).collect()
    }
}