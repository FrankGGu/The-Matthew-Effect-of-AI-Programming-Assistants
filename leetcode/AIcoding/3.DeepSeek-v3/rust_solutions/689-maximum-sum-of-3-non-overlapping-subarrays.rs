impl Solution {
    pub fn max_sum_of_three_subarrays(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let n = nums.len();
        let mut sum = vec![0; n + 1];
        for i in 0..n {
            sum[i + 1] = sum[i] + nums[i];
        }

        let mut left = vec![0; n];
        let mut total = sum[k] - sum[0];
        for i in k..n {
            if sum[i + 1] - sum[i + 1 - k] > total {
                left[i] = i + 1 - k;
                total = sum[i + 1] - sum[i + 1 - k];
            } else {
                left[i] = left[i - 1];
            }
        }

        let mut right = vec![0; n];
        total = sum[n] - sum[n - k];
        right[n - k] = n - k;
        for i in (0..n - k).rev() {
            if sum[i + k] - sum[i] >= total {
                right[i] = i;
                total = sum[i + k] - sum[i];
            } else {
                right[i] = right[i + 1];
            }
        }

        let mut max_sum = 0;
        let mut res = vec![0, 0, 0];
        for i in k..=n - 2 * k {
            let l = left[i - 1];
            let r = right[i + k];
            let current_sum = (sum[l + k] - sum[l]) + (sum[i + k] - sum[i]) + (sum[r + k] - sum[r]);
            if current_sum > max_sum {
                max_sum = current_sum;
                res = vec![l as i32, i as i32, r as i32];
            }
        }
        res
    }
}