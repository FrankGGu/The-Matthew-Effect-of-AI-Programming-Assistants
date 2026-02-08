impl Solution {
    pub fn max_sum_after_partitioning(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();
        let k = k as usize;
        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            let mut max_val = 0;
            for j in 1..=k.min(i) {
                max_val = max_val.max(arr[i - j]);
                dp[i] = dp[i].max(dp[i - j] + max_val * j as i32);
            }
        }

        dp[n]
    }
}