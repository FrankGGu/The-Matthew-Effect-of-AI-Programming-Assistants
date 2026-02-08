impl Solution {
    pub fn contains_nearby_duplicate(nums: Vec<i32>, k: i32) -> bool {
        use std::collections::HashMap;
        let mut map = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            if let Some(&index) = map.get(&num) {
                if (i as i32 - index as i32).abs() <= k {
                    return true;
                }
            }
            map.insert(num, i);
        }
        false
    }
}