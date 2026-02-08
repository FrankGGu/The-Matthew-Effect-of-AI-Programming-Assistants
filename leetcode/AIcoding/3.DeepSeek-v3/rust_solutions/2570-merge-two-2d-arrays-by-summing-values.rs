use std::collections::BTreeMap;

impl Solution {
    pub fn merge_arrays(nums1: Vec<Vec<i32>>, nums2: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut map = BTreeMap::new();

        for num in nums1 {
            let id = num[0];
            let value = num[1];
            *map.entry(id).or_insert(0) += value;
        }

        for num in nums2 {
            let id = num[0];
            let value = num[1];
            *map.entry(id).or_insert(0) += value;
        }

        map.into_iter().map(|(k, v)| vec![k, v]).collect()
    }
}