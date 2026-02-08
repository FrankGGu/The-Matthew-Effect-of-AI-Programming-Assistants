use std::collections::HashMap;

impl Solution {
    pub fn find_pairs(nums: Vec<i32>, k: i32) -> i32 {
        let mut map = HashMap::new();
        let mut count = 0;

        for &num in &nums {
            *map.entry(num).or_insert(0) += 1;
        }

        for &key in map.keys() {
            if k == 0 {
                if let Some(&v) = map.get(&key) {
                    if v > 1 {
                        count += 1;
                    }
                }
            } else if map.contains_key(&(key + k)) {
                count += 1;
            }
        }

        count
    }
}