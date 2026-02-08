use std::collections::HashMap;

impl Solution {
    pub fn max_subarray_length(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_len = 0;
        let mut product = 1;
        let mut map = HashMap::new();
        map.insert(1, -1);

        for i in 0..n {
            product *= nums[i];
            if let Some(&prev_index) = map.get(&product) {
                max_len = max_len.max(i as i32 - prev_index);
            } else {
                map.insert(product, i as i32);
            }
        }

        max_len
    }
}