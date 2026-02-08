use std::collections::HashMap;

impl Solution {
    pub fn merge_similar_items(items1: Vec<Vec<i32>>, items2: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut merged_weights: HashMap<i32, i32> = HashMap::new();

        for item in items1 {
            let value = item[0];
            let weight = item[1];
            *merged_weights.entry(value).or_insert(0) += weight;
        }

        for item in items2 {
            let value = item[0];
            let weight = item[1];
            *merged_weights.entry(value).or_insert(0) += weight;
        }

        let mut result: Vec<Vec<i32>> = merged_weights
            .into_iter()
            .map(|(value, weight)| vec![value, weight])
            .collect();

        result.sort_unstable_by_key(|item| item[0]);

        result
    }
}