impl Solution {
    pub fn max_sum_of_three_subarrays(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;

        let mut window_sums = Vec::with_capacity(n - k + 1);
        let mut current_sum = 0;
        for i in 0..n {
            current_sum += nums[i];
            if i >= k {
                current_sum -= nums[i - k];
            }
            if i >= k - 1 {
                window_sums.push(current_sum);
            }
        }

        let len_ws = window_sums.len();

        let mut left = vec![0; len_ws];
        for i in 1..len_ws {
            if window_sums[i] > window_sums[left[i - 1]] {
                left[i] = i;
            } else {
                left[i] = left[i - 1];
            }
        }

        let mut right = vec![0; len_ws];
        right[len_ws - 1] = len_ws - 1;
        for i in (0..len_ws - 1).rev() {
            if window_sums[i] >= window_sums[right[i + 1]] {
                right[i] = i;
            } else {
                right[i] = right[i + 1];
            }
        }

        let mut max_total_sum = -1;
        let mut result = vec![0, 0, 0];

        for j_idx in k..(len_ws - k) {
            let i_idx = left[j_idx - k];
            let l_idx = right[j_idx + k];

            let current_total_sum = window_sums[i_idx] + window_sums[j_idx] + window_sums[l_idx];

            if current_total_sum > max_total_sum {
                max_total_sum = current_total_sum;
                result = vec![i_idx as i32, j_idx as i32, l_idx as i32];
            }
        }

        result
    }
}