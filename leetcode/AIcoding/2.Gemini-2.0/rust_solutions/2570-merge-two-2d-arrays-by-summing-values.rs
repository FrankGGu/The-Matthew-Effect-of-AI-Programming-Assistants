impl Solution {
    pub fn merge_arrays(nums1: Vec<Vec<i32>>, nums2: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        use std::collections::HashMap;

        let mut map: HashMap<i32, i32> = HashMap::new();

        for row in &nums1 {
            map.insert(row[0], row[1]);
        }

        for row in &nums2 {
            let id = row[0];
            let value = row[1];

            if map.contains_key(&id) {
                *map.get_mut(&id).unwrap() += value;
            } else {
                map.insert(id, value);
            }
        }

        let mut result: Vec<Vec<i32>> = map.into_iter().map(|(k, v)| vec![k, v]).collect();
        result.sort_by(|a, b| a[0].cmp(&b[0]));
        result
    }
}