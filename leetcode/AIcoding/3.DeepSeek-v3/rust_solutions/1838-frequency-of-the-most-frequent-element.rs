impl Solution {
    pub fn max_frequency(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let mut left = 0;
        let mut max_freq = 1;
        let mut total = 0i64;

        for right in 1..nums.len() {
            total += (nums[right] - nums[right - 1]) as i64 * (right - left) as i64;
            while total > k as i64 {
                total -= (nums[right] - nums[left]) as i64;
                left += 1;
            }
            max_freq = max_freq.max((right - left + 1) as i32);
        }

        max_freq
    }
}