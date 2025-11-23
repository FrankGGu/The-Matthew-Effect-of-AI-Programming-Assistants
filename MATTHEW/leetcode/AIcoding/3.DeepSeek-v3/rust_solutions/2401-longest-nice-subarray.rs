impl Solution {
    pub fn longest_nice_subarray(nums: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut max_len = 0;
        let mut current_or = 0;

        for right in 0..nums.len() {
            while (current_or & nums[right]) != 0 {
                current_or ^= nums[left];
                left += 1;
            }
            current_or |= nums[right];
            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}