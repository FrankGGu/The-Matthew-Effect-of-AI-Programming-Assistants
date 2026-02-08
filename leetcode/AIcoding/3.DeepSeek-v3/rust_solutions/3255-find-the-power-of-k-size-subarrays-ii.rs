impl Solution {
    pub fn sum_of_power(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[0][0] = 1;
        let modulo = 1_000_000_007;

        for &num in &nums {
            for i in (1..=n).rev() {
                for j in (num as usize..=k).rev() {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - num as usize]) % modulo;
                }
            }
        }

        let mut res = 0;
        for i in 1..=n {
            res = (res + dp[i][k]) % modulo;
        }
        res
    }
}