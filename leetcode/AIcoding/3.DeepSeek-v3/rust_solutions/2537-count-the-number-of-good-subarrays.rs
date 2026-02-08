use std::collections::HashMap;

impl Solution {
    pub fn count_good_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let mut count = 0;
        let mut freq = HashMap::new();
        let mut left = 0;
        let mut pairs = 0;
        let k = k as i64;

        for right in 0..nums.len() {
            let num = nums[right];
            let entry = freq.entry(num).or_insert(0);
            pairs += *entry;
            *entry += 1;

            while pairs >= k {
                let left_num = nums[left];
                let left_entry = freq.get_mut(&left_num).unwrap();
                *left_entry -= 1;
                pairs -= *left_entry;
                left += 1;
            }
            count += left as i64;
        }

        count
    }
}