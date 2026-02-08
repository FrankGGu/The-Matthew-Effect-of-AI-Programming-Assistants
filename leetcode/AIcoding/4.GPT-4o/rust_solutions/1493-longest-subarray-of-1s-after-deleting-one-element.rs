impl Solution {
    pub fn longest_subarray(nums: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut zero_count = 0;
        let mut max_length = 0;

        for right in 0..nums.len() {
            if nums[right] == 0 {
                zero_count += 1;
            }

            while zero_count > 1 {
                if nums[left] == 0 {
                    zero_count -= 1;
                }
                left += 1;
            }

            max_length = max_length.max(right - left);
        }

        max_length
    }
}