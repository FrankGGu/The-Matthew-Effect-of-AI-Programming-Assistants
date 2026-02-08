impl Solution {
    pub fn min_changes(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![vec![0; 1024]; k];
        let mut count = vec![vec![0; 1024]; k];

        for i in 0..k {
            for j in 0..(n + k - 1) / k {
                let idx = i + j * k;
                if idx < n {
                    count[i][nums[idx] as usize] += 1;
                }
            }
        }

        for i in 0..k {
            for mask in 0..1024 {
                dp[i][mask] = count[i][mask];
                for j in 0..=mask {
                    if j ^ mask < 1024 {
                        dp[i][mask] = dp[i][mask].max(count[i][j] + dp[i][j ^ mask]);
                    }
                }
            }
        }

        let mut ans = n;
        for mask in 0..1024 {
            let mut total = 0;
            for i in 0..k {
                total += dp[i][mask];
            }
            ans = ans.min(n - total);
        }

        ans
    }
}