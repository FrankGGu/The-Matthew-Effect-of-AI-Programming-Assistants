use std::collections::HashMap;

impl Solution {
    pub fn contains_nearby_duplicate(nums: Vec<i32>, k: i32) -> bool {
        let mut map = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            if let Some(&prev_index) = map.get(&num) {
                if (i as i32 - prev_index as i32) <= k {
                    return true;
                }
            }
            map.insert(num, i);
        }
        false
    }
}