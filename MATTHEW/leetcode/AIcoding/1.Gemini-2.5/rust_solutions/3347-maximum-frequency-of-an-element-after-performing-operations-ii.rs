impl Solution {
    pub fn max_frequency(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable();
        let n = nums.len();
        let mut left = 0;
        let mut current_sum: i64 = 0;
        let mut max_freq = 0;
        let k_long = k as i64;

        for right in 0..n {
            current_sum += nums[right] as i64;

            // The cost to make all elements in the window [left...right] equal to nums[right]
            // is (window_size * nums[right]) - sum_of_elements_in_window.
            // If this cost exceeds k, we need to shrink the window from the left.
            while (right - left + 1) as i64 * nums[right] as i64 - current_sum > k_long {
                current_sum -= nums[left] as i64;
                left += 1;
            }

            // The current window [left...right] is valid. Update max_freq.
            max_freq = max_freq.max((right - left + 1) as i32);
        }

        max_freq
    }
}