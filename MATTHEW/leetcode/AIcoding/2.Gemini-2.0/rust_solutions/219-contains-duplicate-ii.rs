use std::collections::HashMap;

impl Solution {
    pub fn contains_nearby_duplicate(nums: Vec<i32>, k: i32) -> bool {
        let mut map: HashMap<i32, usize> = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            if let Some(&j) = map.get(&num) {
                if (i as i32 - j as i32).abs() <= k {
                    return true;
                }
            }
            map.insert(num, i);
        }
        false
    }
}