impl Solution {
    pub fn sum_of_power(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mod_val = 1_000_000_007;
        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[0][0] = 1;

        for &num in &nums {
            let num = num as usize;
            for i in (0..=n).rev() {
                for j in (0..=k).rev() {
                    if i + 1 <= n && j + num <= k {
                        dp[i + 1][j + num] = (dp[i + 1][j + num] + dp[i][j]) % mod_val;
                    }
                }
            }
        }

        let mut res = 0;
        let mut pow = 1;
        for i in 1..=n {
            res = (res + dp[i][k] as i64 * pow % mod_val as i64) as i64 % mod_val as i64;
            pow = pow * 2 % mod_val as i64;
        }

        res as i32
    }
}