impl Solution {
    pub fn max_sum_of_three_subarrays(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k_usize = k as usize;

        // Calculate prefix sums
        // prefix_sum[i] stores the sum of nums[0...i-1]
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        // Calculate sums of all possible subarrays of length k
        // window_sums[i] stores the sum of nums[i...i+k-1]
        // There are n - k + 1 such windows, starting from index 0 to n - k.
        let num_windows = n - k_usize + 1;
        let mut window_sums: Vec<i664> = vec![0; num_windows];
        for i in 0..num_windows {
            window_sums[i] = prefix_sum[i + k_usize] - prefix_sum[i];
        }

        // left[i] stores the starting index of the best (max sum) subarray of length k
        // in window_sums[0...i]. If sums are equal, choose the smaller index.
        let mut left: Vec<i32> = vec![0; num_windows];
        left[0] = 0;
        for i in 1..num_windows {
            if window_sums[i] > window_sums[left[i - 1] as usize] {
                left[i] = i as i32;
            } else {
                left[i] = left[i - 1];
            }
        }

        // right[i] stores the starting index of the best (max sum) subarray of length k
        // in window_sums[i...num_windows-1]. If sums are equal, choose the smaller index.
        let mut right: Vec<i332> = vec![0; num_windows];
        right[num_windows - 1] = (num_windows - 1) as i32;
        for i in (0..num_windows - 1).rev() {
            if window_sums[i] >= window_sums[right[i + 1] as usize] {
                right[i] = i as i32;
            } else {
                right[i] = right[i + 1];
            }
        }

        let mut max_total_sum: i64 = 0;
        let mut result_indices: Vec<i32> = vec![0, 0, 0];

        // Iterate for the middle subarray's starting index
        // The middle subarray can start from index k up to n - 2*k.
        // i_mid is the starting index of the middle subarray in nums (and window_sums).
        for i_mid in k_usize..(n - 2 * k_usize + 1) {
            // The left subarray must start at an index <= i_mid - k.
            // So we look up the best left subarray in `left[0...i_mid - k]`.
            let l_idx = left[i_mid - k_usize] as usize;

            // The right subarray must start at an index >= i_mid + k.
            // So we look up the best right subarray in `right[i_mid + k...num_windows-1]`.
            let r_idx = right[i_mid + k_usize] as usize;

            let current_total_sum = window_sums[l_idx] + window_sums[i_mid] + window_sums[r_idx];

            if current_total_sum > max_total_sum {
                max_total_sum = current_total_sum;
                result_indices = vec![l_idx as i32, i_mid as i32, r_idx as i32];
            }
        }

        result_indices
    }
}