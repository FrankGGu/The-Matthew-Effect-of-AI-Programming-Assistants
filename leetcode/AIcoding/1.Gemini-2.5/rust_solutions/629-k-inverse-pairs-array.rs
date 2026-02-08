impl Solution {
    pub fn k_inverse_pairs(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let modulo = 1_000_000_007;

        let mut dp = vec![0; k + 1];
        dp[0] = 1;

        for i in 1..=n {
            let mut new_dp = vec![0; k + 1];
            new_dp[0] = 1; 
            for j in 1..=k {
                new_dp[j] = (new_dp[j-1] + dp[j]) % modulo;
                if j >= i {
                    new_dp[j] = (new_dp[j] - dp[j-i] + modulo) % modulo;
                }
            }
            dp = new_dp;
        }

        dp[k]
    }
}