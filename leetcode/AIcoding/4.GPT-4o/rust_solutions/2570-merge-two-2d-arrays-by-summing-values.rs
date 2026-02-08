use std::collections::HashMap;

pub fn merge_arrays(nums1: Vec<Vec<i32>>, nums2: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut map = HashMap::new();

    for arr in nums1 {
        map.insert(arr[0], arr[1]);
    }

    for arr in nums2 {
        let entry = map.entry(arr[0]).or_insert(0);
        *entry += arr[1];
    }

    let mut result: Vec<Vec<i32>> = map.into_iter().collect();
    result.sort_by(|a, b| a[0].cmp(&b[0]));
    result
}