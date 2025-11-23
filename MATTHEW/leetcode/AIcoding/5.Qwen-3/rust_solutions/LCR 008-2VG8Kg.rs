struct Solution;

impl Solution {
    pub fn min_subarray_len(s: i32, nums: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut current_sum = 0;
        let mut min_length = std::i32::MAX;

        for right in 0..nums.len() {
            current_sum += nums[right];

            while current_sum >= s {
                min_length = std::cmp::min(min_length, (right - left + 1) as i32);
                current_sum -= nums[left];
                left += 1;
            }
        }

        if min_length == std::i32::MAX {
            0
        } else {
            min_length
        }
    }
}