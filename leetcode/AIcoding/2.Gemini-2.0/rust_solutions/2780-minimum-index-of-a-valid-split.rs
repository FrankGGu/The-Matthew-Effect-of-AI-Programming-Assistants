use std::collections::HashMap;

impl Solution {
    pub fn minimum_index(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total_count = HashMap::new();
        for &num in &nums {
            *total_count.entry(num).or_insert(0) += 1;
        }

        let mut dominant = 0;
        let mut dominant_count = 0;
        for (&num, &count) in &total_count {
            if count > dominant_count {
                dominant = num;
                dominant_count = count;
            }
        }

        let mut left_count = 0;
        for i in 0..n - 1 {
            if nums[i] == dominant {
                left_count += 1;
            }
            if left_count * 2 > (i + 1) && (dominant_count - left_count) * 2 > (n - i - 1) {
                return i as i32;
            }
        }

        -1
    }
}