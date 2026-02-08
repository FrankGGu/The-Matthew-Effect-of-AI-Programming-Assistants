impl Solution {
    pub fn find_integers(n: i32) -> i32 {
        let mut dp = vec![0; 32];
        dp[0] = 1;
        dp[1] = 2;
        for i in 2..32 {
            dp[i] = dp[i - 1] + dp[i - 2];
        }

        let mut result = 0;
        let mut prev_bit = 0;
        let mut num = n;

        for i in (0..31).rev() {
            if (num >> i) & 1 == 1 {
                result += dp[i];
                if prev_bit == 1 {
                    return result;
                }
                prev_bit = 1;
            } else {
                prev_bit = 0;
            }
        }

        result + 1
    }
}