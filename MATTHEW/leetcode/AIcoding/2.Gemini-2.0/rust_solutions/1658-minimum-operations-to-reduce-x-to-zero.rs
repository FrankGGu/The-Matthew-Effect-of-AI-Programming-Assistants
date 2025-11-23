use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, x: i32) -> i32 {
        let n = nums.len();
        let target = nums.iter().sum::<i32>() - x;

        if target < 0 {
            return -1;
        }

        let mut max_len = -1;
        let mut current_sum = 0;
        let mut sum_index_map: HashMap<i32, i32> = HashMap::new();
        sum_index_map.insert(0, -1);

        for i in 0..n {
            current_sum += nums[i];
            if sum_index_map.contains_key(&(current_sum - target)) {
                let start_index = sum_index_map[&(current_sum - target)];
                max_len = max_len.max(i as i32 - start_index);
            }
            sum_index_map.insert(current_sum, i as i32);
        }

        if max_len == -1 {
            return -1;
        }

        n as i32 - max_len
    }
}