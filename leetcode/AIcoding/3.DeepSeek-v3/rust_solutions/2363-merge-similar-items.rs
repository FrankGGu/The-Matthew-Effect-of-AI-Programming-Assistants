use std::collections::BTreeMap;

impl Solution {
    pub fn merge_similar_items(items1: Vec<Vec<i32>>, items2: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut map = BTreeMap::new();

        for item in items1 {
            let (value, weight) = (item[0], item[1]);
            *map.entry(value).or_insert(0) += weight;
        }

        for item in items2 {
            let (value, weight) = (item[0], item[1]);
            *map.entry(value).or_insert(0) += weight;
        }

        map.into_iter().map(|(value, weight)| vec![value, weight]).collect()
    }
}