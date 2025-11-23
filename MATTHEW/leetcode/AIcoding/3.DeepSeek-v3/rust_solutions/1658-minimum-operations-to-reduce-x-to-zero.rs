use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, x: i32) -> i32 {
        let total: i32 = nums.iter().sum();
        let target = total - x;
        if target < 0 {
            return -1;
        }
        if target == 0 {
            return nums.len() as i32;
        }
        let mut sum = 0;
        let mut max_len = 0;
        let mut map = HashMap::new();
        map.insert(0, -1);
        for (i, &num) in nums.iter().enumerate() {
            sum += num;
            if let Some(&prev) = map.get(&(sum - target)) {
                max_len = max_len.max(i as i32 - prev);
            }
            map.entry(sum).or_insert(i as i32);
        }
        if max_len == 0 {
            -1
        } else {
            nums.len() as i32 - max_len
        }
    }
}