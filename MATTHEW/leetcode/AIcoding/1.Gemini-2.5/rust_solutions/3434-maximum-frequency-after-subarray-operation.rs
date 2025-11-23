impl Solution {
    pub fn max_frequency(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable();

        let n = nums.len();
        let mut left: usize = 0;
        let mut current_sum: i64 = 0;
        let mut max_freq: i32 = 0;
        let k_long = k as i64;

        for right in 0..n {
            current_sum += nums[right] as i64;

            // Calculate the cost to make all elements in the current window [left..right] equal to nums[right].
            // Cost = (nums[right] * window_size) - sum_of_elements_in_window
            // If the cost exceeds k, shrink the window from the left.
            while (nums[right] as i64 * (right - left + 1) as i64) - current_sum > k_long {
                current_sum -= nums[left] as i64;
                left += 1;
            }

            // The current window [left..right] is valid. Update max_freq.
            max_freq = max_freq.max((right - left + 1) as i32);
        }

        max_freq
    }
}