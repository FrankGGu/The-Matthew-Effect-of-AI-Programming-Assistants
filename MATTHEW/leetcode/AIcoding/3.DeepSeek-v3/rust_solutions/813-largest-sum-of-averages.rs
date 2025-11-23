impl Solution {
    pub fn largest_sum_of_averages(nums: Vec<i32>, k: i32) -> f64 {
        let n = nums.len();
        let k = k as usize;
        let mut prefix = vec![0.0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i] as f64;
        }

        let mut dp = vec![0.0; n];
        for i in 0..n {
            dp[i] = (prefix[n] - prefix[i]) / (n - i) as f64;
        }

        for _k in 2..=k {
            for i in 0..n {
                for j in i + 1..n {
                    let avg = (prefix[j] - prefix[i]) / (j - i) as f64;
                    dp[i] = dp[i].max(avg + dp[j]);
                }
            }
        }

        dp[0]
    }
}