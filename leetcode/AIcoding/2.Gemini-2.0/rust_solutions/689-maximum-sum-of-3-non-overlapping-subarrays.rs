impl Solution {
    pub fn max_sum_of_three_subarrays(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let n = nums.len();
        let mut sum = vec![0; n + 1];
        for i in 0..n {
            sum[i + 1] = sum[i] + nums[i];
        }

        let mut left = vec![0; n];
        let mut best = 0;
        for i in k..=n - k {
            if sum[i + 1] - sum[i - k] > sum[best + 1] - sum[best] {
                best = i - k;
            }
            left[i] = best;
        }

        let mut right = vec![0; n];
        best = n - 2 * k;
        for i in (k..=n - k).rev() {
            if sum[i + k + 1] - sum[i] >= sum[best + k + 1] - sum[best] {
                best = i;
            }
            right[i] = best;
        }

        let mut ans = vec![0, 0, 0];
        let mut max_sum = 0;
        for j in k..=n - 2 * k {
            let i = left[j];
            let l = right[j + k];
            let cur_sum = (sum[i + k + 1] - sum[i]) + (sum[j + k + 1] - sum[j]) + (sum[l + k + 1] - sum[l]);
            if cur_sum > max_sum {
                max_sum = cur_sum;
                ans[0] = i as i32;
                ans[1] = j as i32;
                ans[2] = l as i32;
            }
        }
        ans
    }
}