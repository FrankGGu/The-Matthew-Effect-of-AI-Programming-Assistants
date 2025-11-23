impl Solution {
    pub fn good_subsequences(nums: Vec<i32>) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let max_num = *nums.iter().max().unwrap_or(&0) as usize;
        let mut freq = vec![0; max_num + 1];
        for &num in &nums {
            freq[num as usize] += 1;
        }

        let mut dp = vec![0; max_num + 1];
        let mut res = 0;
        for i in 1..=max_num {
            if freq[i] == 0 {
                continue;
            }
            dp[i] = freq[i] as i64;
            for j in 1..i {
                if i % j == 0 {
                    dp[i] = (dp[i] + dp[j] * freq[i] as i64) % MOD;
                }
            }
            res = (res + dp[i]) % MOD;
        }
        res as i32
    }
}