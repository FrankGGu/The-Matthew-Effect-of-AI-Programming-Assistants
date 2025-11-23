impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_color_pairs(nums: Vec<i32>, target: i32) -> i32 {
        let mut count = 0;
        let mut map = HashMap::new();

        for num in nums {
            let complement = target - num;
            if let Some(&v) = map.get(&complement) {
                count += v;
            }
            *map.entry(num).or_insert(0) += 1;
        }

        count
    }
}
}