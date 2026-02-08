impl Solution {
    pub fn max_sum_after_partitioning(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();
        let k = k as usize;
        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            let mut max_val = 0;
            let mut max_sum = 0;
            for j in 1..=k {
                if i >= j {
                    max_val = max_val.max(arr[i - j]);
                    max_sum = max_sum.max(dp[i - j] + max_val * j as i32);
                }
            }
            dp[i] = max_sum;
        }

        dp[n]
    }
}