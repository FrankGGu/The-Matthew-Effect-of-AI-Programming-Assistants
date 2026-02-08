impl Solution {
    pub fn min_time_to_break_locks(locks: Vec<i32>) -> i32 {
        let n = locks.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return locks[0];
        }

        let mut dp = vec![0; n + 1];

        dp[0] = 0;
        dp[1] = locks[0];

        for i in 2..=n {
            // Option 1: Break lock (i-1) individually
            // This means we've broken locks[0]...locks[i-2] (cost dp[i-1]) and now add locks[i-1]'s time.
            let cost_single = dp[i - 1] + locks[i - 1];

            // Option 2: Break locks (i-2) and (i-1) together
            // This means we've broken locks[0]...locks[i-3] (cost dp[i-2]) and now add
            // the combined time for locks[i-2] and locks[i-1].
            // Assuming the cost for breaking two adjacent locks together is the maximum of their individual times.
            let cost_pair = dp[i - 2] + locks[i - 2].max(locks[i - 1]);

            dp[i] = cost_single.min(cost_pair);
        }

        dp[n]
    }
}