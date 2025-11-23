impl Solution {
    pub fn count_balanced_permutations(n: i32) -> i32 {
        let n = n as usize;
        if n % 2 == 1 {
            return 0;
        }
        let m = n / 2;
        let mut dp = vec![0; m + 1];
        dp[0] = 1;
        for i in 1..=m {
            for j in 0..i {
                dp[i] += dp[j] * dp[i - 1 - j];
            }
        }
        dp[m] as i32
    }
}