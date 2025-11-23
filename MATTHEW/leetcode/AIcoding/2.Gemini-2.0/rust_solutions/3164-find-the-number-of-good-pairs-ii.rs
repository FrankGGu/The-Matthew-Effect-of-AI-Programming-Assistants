use std::collections::HashMap;

impl Solution {
    pub fn count_good_pairs(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut map: HashMap<i32, i32> = HashMap::new();

        for &num in &nums {
            if map.contains_key(&num) {
                count += map[&num];
                map.insert(num, map[&num] + 1);
            } else {
                map.insert(num, 1);
            }
        }

        count
    }
}