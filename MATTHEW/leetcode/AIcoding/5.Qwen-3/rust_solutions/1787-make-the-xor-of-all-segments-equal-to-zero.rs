impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, x: i32) -> i32 {
        let total: i32 = nums.iter().sum();
        let target = total - x;
        if target < 0 {
            return -1;
        }
        let mut prefix_sum = 0;
        let mut map = HashMap::new();
        map.insert(0, -1);
        let mut max_len = -1;
        for (i, &num) in nums.iter().enumerate() {
            prefix_sum += num;
            if let Some(&j) = map.get(&(prefix_sum - target)) {
                max_len = std::cmp::max(max_len, i as i32 - j);
            }
            map.insert(prefix_sum, i as i32);
        }
        if max_len == -1 {
            -1
        } else {
            (nums.len() as i32 - max_len)
        }
    }
}
}