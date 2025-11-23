use std::collections::HashMap;

impl Solution {
    pub fn longest_equal_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut freq_map: HashMap<i32, i32> = HashMap::new();
        let mut max_freq_in_window = 0;
        let mut left = 0;
        let mut max_len = 0;

        for right in 0..n {
            let num_r = nums[right];
            *freq_map.entry(num_r).or_insert(0) += 1;
            max_freq_in_window = max_freq_in_window.max(freq_map[&num_r]);

            // The current window is nums[left..right].
            // Its length is (right - left + 1).
            // To make all elements in this window equal to the most frequent element,
            // we need to remove (current_window_length - max_freq_in_window) elements.
            // If this count exceeds k, the window is invalid, and we must shrink it from the left.
            while (right - left + 1) as i32 - max_freq_in_window > k {
                let num_l = nums[left];
                *freq_map.get_mut(&num_l).unwrap() -= 1;
                // Importantly, max_freq_in_window is NOT updated (decreased) here.
                // It retains its value, representing the maximum frequency observed
                // in any valid window considered so far. This is a key optimization
                // for this type of sliding window problem to achieve O(N) complexity.
                left += 1;
            }

            // At this point, the window nums[left..right] is valid.
            // Update max_len with the current window length.
            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}