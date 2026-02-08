const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn number_of_great_partitions(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as i64;
        let sum: i64 = nums.iter().map(|&x| x as i64).sum();

        if sum < 2 * k {
            return 0;
        }

        let n = nums.len();
        let mut dp = vec![0; (k as usize)];
        dp[0] = 1;

        for &num in &nums {
            let num = num as i64;
            for j in (num as usize..k as usize).rev() {
                dp[j] = (dp[j] + dp[j - num as usize]) % MOD;
            }
        }

        let mut less_than_k = dp.iter().fold(0, |acc, &x| (acc + x) % MOD);

        let mut ans = 1;
        for _ in 0..n {
            ans = (ans * 2) % MOD;
        }

        ans = (ans - 2 * less_than_k + MOD * 2) % MOD;

        ans as i32
    }
}