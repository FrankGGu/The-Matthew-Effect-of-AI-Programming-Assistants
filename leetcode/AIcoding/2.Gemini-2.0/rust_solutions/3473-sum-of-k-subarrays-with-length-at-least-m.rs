impl Solution {
    pub fn max_sum_subarray(nums: Vec<i32>, m: i32) -> i64 {
        let n = nums.len();
        let m = m as usize;
        if n < m {
            return i64::MIN;
        }

        let mut prefix_sum = vec![0i64; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let mut max_sum = i64::MIN;
        for i in 0..=n - m {
            max_sum = max_sum.max(prefix_sum[i + m] - prefix_sum[i]);
        }

        max_sum
    }

    pub fn max_sum_k_subarrays(nums: Vec<i32>, k: i32, m: i32) -> i64 {
        let n = nums.len();
        let k = k as usize;
        let m = m as usize;

        if k * m > n {
            return -1;
        }

        let mut dp = vec![vec![i64::MIN; k + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 0..=k {
                dp[i][j] = dp[i - 1][j];
                if j > 0 && i >= m {
                    let subarray = nums[i - m..i].to_vec();
                    let sum = Solution::max_sum_subarray(subarray, m as i32);
                    if sum != i64::MIN && dp[i - m][j - 1] != i64::MIN {
                        dp[i][j] = dp[i][j].max(dp[i - m][j - 1] + sum);
                    }
                }
            }
        }

        dp[n][k]
    }
}