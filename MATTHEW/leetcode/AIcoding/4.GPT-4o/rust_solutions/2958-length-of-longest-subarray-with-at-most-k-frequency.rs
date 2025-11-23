use std::collections::HashMap;

impl Solution {
    pub fn longest_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = HashMap::new();
        let (mut left, mut max_length) = (0, 0);

        for right in 0..nums.len() {
            *count.entry(nums[right]).or_insert(0) += 1;

            while count.len() > k as usize {
                let left_num = nums[left];
                *count.get_mut(&left_num).unwrap() -= 1;
                if count[&left_num] == 0 {
                    count.remove(&left_num);
                }
                left += 1;
            }
            max_length = max_length.max(right - left + 1);
        }

        max_length
    }
}