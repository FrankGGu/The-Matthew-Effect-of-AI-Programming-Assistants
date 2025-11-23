impl Solution {
    pub fn count_special_subsequences(nums: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = nums.len();
        let mut dp = vec![0; n + 1];
        let mut count = vec![0; 3];
        dp[0] = 1;

        for &num in &nums {
            let num = (num - 1) as usize;
            count[num] += 1;
            dp[count[0]] = (dp[count[0]] + dp[count[0] - 1]) % MOD;

            if count[1] > 0 {
                dp[count[1]] = (dp[count[1]] + dp[count[1] - 1]) % MOD;
            }
            if count[2] > 0 {
                dp[count[2]] = (dp[count[2]] + dp[count[2] - 1]) % MOD;
            }
        }

        let mut result = 0;
        for &c in &count {
            result = (result + dp[c]) % MOD;
        }

        result
    }
}