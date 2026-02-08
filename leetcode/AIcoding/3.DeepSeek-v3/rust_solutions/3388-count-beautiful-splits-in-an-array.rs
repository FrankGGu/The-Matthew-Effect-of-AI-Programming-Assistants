impl Solution {
    pub fn beautiful_splits(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        let total = prefix[n];
        let modulo = 1_000_000_007;
        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        for _ in 1..=k {
            let mut next = vec![0; n + 1];
            let mut sum = 0;
            for j in 1..=n {
                sum = (sum + dp[j - 1]) % modulo;
                if prefix[j] * 2 <= total {
                    next[j] = sum;
                }
            }
            dp = next;
        }
        dp[n] % modulo
    }
}