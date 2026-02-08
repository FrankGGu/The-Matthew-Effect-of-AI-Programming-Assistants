impl Solution {
    pub fn count_partitions(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let total_sum: i64 = nums.iter().map(|&x| x as i64).sum();
        if total_sum < 2 * k as i64 {
            return 0;
        }

        let mod_val = 1_000_000_007;
        let mut dp = vec![0; k];
        dp[0] = 1;

        for &num in nums.iter() {
            let num = num as usize;
            for j in (num..k).rev() {
                dp[j] = (dp[j] + dp[j - num]) % mod_val;
            }
        }

        let mut total = 1;
        for _ in 0..nums.len() {
            total = (total * 2) % mod_val;
        }

        let mut bad = 0;
        for &cnt in dp.iter() {
            bad = (bad + cnt) % mod_val;
        }
        bad = (bad * 2) % mod_val;

        ((total - bad + mod_val) % mod_val as i32
    }
}