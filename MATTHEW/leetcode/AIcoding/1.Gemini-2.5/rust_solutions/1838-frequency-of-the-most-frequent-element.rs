impl Solution {
    pub fn max_frequency(mut nums: Vec<i332>, k: i32) -> i32 {
        nums.sort_unstable();

        let n = nums.len();
        let k = k as i64;

        let mut left: usize = 0;
        let mut current_sum: i64 = 0;
        let mut max_freq: i32 = 0;

        for right in 0..n {
            current_sum += nums[right] as i64;

            while (right - left + 1) as i64 * (nums[right] as i64) - current_sum > k {
                current_sum -= nums[left] as i64;
                left += 1;
            }

            max_freq = max_freq.max((right - left + 1) as i32);
        }

        max_freq
    }
}