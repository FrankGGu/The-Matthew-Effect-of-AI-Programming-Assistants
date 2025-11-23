impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(nums: Vec<i32>, k: i32) -> i32 {
        let mut map = HashMap::new();
        let mut count = 0;

        for num in nums {
            let key = num % k;
            count += *map.get(&key).unwrap_or(&0);
            *map.entry(key).or_insert(0) += 1;
        }

        count
    }
}
}