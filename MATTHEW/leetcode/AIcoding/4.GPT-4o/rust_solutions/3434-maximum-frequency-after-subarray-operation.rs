impl Solution {
    pub fn max_frequency(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut left = 0;
        let mut total = 0;
        let mut max_freq = 0;

        for right in 0..nums.len() {
            total += nums[right];

            while nums[right] * (right + 1 - left) > total + k {
                total -= nums[left];
                left += 1;
            }

            max_freq = max_freq.max(right + 1 - left);
        }

        max_freq
    }
}