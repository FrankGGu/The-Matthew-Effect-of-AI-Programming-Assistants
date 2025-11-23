impl Solution {
    pub fn find_integers(n: i32) -> i32 {
        let mut dp = vec![0; 32];
        dp[0] = 1;
        dp[1] = 2;
        for i in 2..32 {
            dp[i] = dp[i - 1] + dp[i - 2];
        }
        let mut k = 30;
        let mut prev_bit = 0;
        let mut res = 0;
        while k >= 0 {
            if (n & (1 << k)) != 0 {
                res += dp[k as usize];
                if prev_bit == 1 {
                    return res;
                }
                prev_bit = 1;
            } else {
                prev_bit = 0;
            }
            k -= 1;
        }
        res + 1
    }
}