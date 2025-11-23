use std::collections::HashMap;

impl Solution {
    pub fn subarrays_with_k_distinct(nums: Vec<i32>, k: i32) -> i32 {
        fn at_most_k(nums: &[i32], k: i32) -> i32 {
            let mut count = 0;
            let mut map = HashMap::new();
            let mut left = 0;
            for right in 0..nums.len() {
                *map.entry(nums[right]).or_insert(0) += 1;
                while map.len() > k as usize {
                    let left_num = nums[left];
                    if let Some(entry) = map.get_mut(&left_num) {
                        *entry -= 1;
                        if *entry == 0 {
                            map.remove(&left_num);
                        }
                    }
                    left += 1;
                }
                count += (right - left + 1) as i32;
            }
            count
        }
        at_most_k(&nums, k) - at_most_k(&nums, k - 1)
    }
}