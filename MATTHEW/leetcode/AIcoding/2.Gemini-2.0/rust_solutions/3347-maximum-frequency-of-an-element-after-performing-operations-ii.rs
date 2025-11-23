impl Solution {
    pub fn max_frequency(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut left = 0;
        let mut right = 0;
        let mut current_sum: i64 = 0;
        let mut max_freq = 0;

        while right < nums.len() {
            current_sum += nums[right] as i64;

            while (nums[right] as i64 * (right - left + 1) as i64) - current_sum > k as i64 {
                current_sum -= nums[left] as i64;
                left += 1;
            }

            max_freq = max_freq.max((right - left + 1) as i32);
            right += 1;
        }

        max_freq
    }
}