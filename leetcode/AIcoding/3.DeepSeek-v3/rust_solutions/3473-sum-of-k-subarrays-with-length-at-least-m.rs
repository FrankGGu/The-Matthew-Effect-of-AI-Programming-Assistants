impl Solution {
    pub fn sum_k_subarrays(nums: Vec<i32>, k: i32, m: i32) -> i32 {
        let k = k as usize;
        let m = m as usize;
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        let mut dp = vec![0; n + 1];
        let mut res = 0;

        for i in m..=n {
            let current = prefix[i] - prefix[i - m];
            if i >= k {
                dp[i] = dp[i - 1].max(current + if i >= m + k { dp[i - m] } else { 0 });
                res = res.max(dp[i]);
            } else {
                dp[i] = current;
                res = res.max(dp[i]);
            }
        }

        res
    }
}