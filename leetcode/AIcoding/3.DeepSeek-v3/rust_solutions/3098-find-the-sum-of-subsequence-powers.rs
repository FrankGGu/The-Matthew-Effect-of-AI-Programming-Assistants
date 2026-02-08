impl Solution {
    pub fn sum_of_power(nums: Vec<i32>, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[0][0] = 1;

        for &num in &nums {
            for i in (0..=n).rev() {
                for j in (0..=k).rev() {
                    if i + 1 <= n && j + num as usize <= k {
                        dp[i + 1][j + num as usize] = (dp[i + 1][j + num as usize] + dp[i][j]) % MOD;
                    }
                }
            }
        }

        let mut res = 0;
        let mut pow = 1;
        for m in 1..=n {
            res = (res + dp[m][k] as i64 * pow as i64) % MOD as i64;
            pow = pow * 2 % MOD;
        }
        res as i32
    }
}