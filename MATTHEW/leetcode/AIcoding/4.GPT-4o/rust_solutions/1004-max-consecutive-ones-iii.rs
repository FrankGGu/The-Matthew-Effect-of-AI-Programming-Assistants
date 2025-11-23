impl Solution {
    pub fn longest_ones(nums: Vec<i32>, k: i32) -> i32 {
        let (mut left, mut right, mut max_length, mut zero_count) = (0, 0, 0, 0);
        while right < nums.len() {
            if nums[right] == 0 {
                zero_count += 1;
            }
            while zero_count > k {
                if nums[left] == 0 {
                    zero_count -= 1;
                }
                left += 1;
            }
            max_length = max_length.max(right - left + 1);
            right += 1;
        }
        max_length
    }
}