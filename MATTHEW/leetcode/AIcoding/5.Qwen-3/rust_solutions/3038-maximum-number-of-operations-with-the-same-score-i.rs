impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        let mut map = HashMap::new();
        for &num in &nums {
            *map.entry(num).or_insert(0) += 1;
        }

        let mut max_ops = 0;
        for (&key, &count) in &map {
            let target = key;
            let mut ops = 0;
            let mut left = 0;
            let mut right = n - 1;
            while left < right {
                if nums[left] + nums[right] == target {
                    ops += 1;
                    left += 1;
                    right -= 1;
                } else if nums[left] + nums[right] < target {
                    left += 1;
                } else {
                    right -= 1;
                }
            }
            max_ops = max_ops.max(ops);
        }

        max_ops
    }
}
}