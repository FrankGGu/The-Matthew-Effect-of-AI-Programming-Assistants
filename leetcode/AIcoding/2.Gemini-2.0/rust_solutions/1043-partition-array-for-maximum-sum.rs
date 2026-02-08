impl Solution {
    pub fn max_sum_after_partitioning(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();
        let k = k as usize;
        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            let mut max_val = 0;
            for j in 1..=std::cmp::min(k, i) {
                max_val = std::cmp::max(max_val, arr[i - j]);
                dp[i] = std::cmp::max(dp[i], dp[i - j] + max_val * (j as i32));
            }
        }

        dp[n]
    }
}