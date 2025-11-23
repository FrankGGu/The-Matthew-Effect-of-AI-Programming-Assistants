use std::collections::HashMap;

impl Solution {
    pub fn merge_arrays(nums1: Vec<Vec<i32>>, nums2: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut map: HashMap<i32, i32> = HashMap::new();

        for pair in nums1 {
            let id = pair[0];
            let value = pair[1];
            *map.entry(id).or_insert(0) += value;
        }

        for pair in nums2 {
            let id = pair[0];
            let value = pair[1];
            *map.entry(id).or_insert(0) += value;
        }

        let mut result: Vec<Vec<i32>> = map
            .into_iter()
            .map(|(id, value)| vec![id, value])
            .collect();

        result.sort_by_key(|pair| pair[0]);

        result
    }
}