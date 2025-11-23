impl Solution {
    pub fn max_sum_of_three_subarrays(cover: Vec<i32>, k: i32) -> Vec<i32> {
        let n = cover.len();
        let k = k as usize;
        let mut left = vec![0; n];
        let mut right = vec![0; n];
        let mut dp = vec![0; n];

        let mut sum = 0;
        for i in 0..n {
            sum += cover[i];
            if i >= k - 1 {
                dp[i] = sum;
                if i == k - 1 {
                    left[i] = i;
                } else {
                    left[i] = if dp[i] > dp[left[i - 1]] { i } else { left[i - 1] };
                }
                sum -= cover[i - k + 1];
            }
        }

        sum = 0;
        for i in (0..n).rev() {
            sum += cover[i];
            if i <= n - k {
                dp[i] = sum;
                if i == n - k {
                    right[i] = i;
                } else {
                    right[i] = if dp[i] > dp[right[i + 1]] { i } else { right[i + 1] };
                }
                sum -= cover[i + k - 1];
            }
        }

        let mut res = vec![0; 3];
        let mut max_sum = 0;

        for i in k..n - k + 1 {
            let l = left[i - 1];
            let r = right[i + k];
            let current_sum = dp[l] + dp[i] + dp[r];
            if current_sum > max_sum {
                max_sum = current_sum;
                res[0] = l as i32;
                res[1] = i as i32;
                res[2] = r as i32;
            }
        }

        res
    }
}