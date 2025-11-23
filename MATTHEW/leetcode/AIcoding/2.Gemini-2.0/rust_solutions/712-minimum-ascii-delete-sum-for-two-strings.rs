impl Solution {
    pub fn minimum_delete_sum(s1: String, s2: String) -> i32 {
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let m = s1_bytes.len();
        let n = s2_bytes.len();

        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in (0..m).rev() {
            dp[i][n] = dp[i + 1][n] + s1_bytes[i] as i32;
        }

        for j in (0..n).rev() {
            dp[m][j] = dp[m][j + 1] + s2_bytes[j] as i32;
        }

        for i in (0..m).rev() {
            for j in (0..n).rev() {
                if s1_bytes[i] == s2_bytes[j] {
                    dp[i][j] = dp[i + 1][j + 1];
                } else {
                    dp[i][j] = (s1_bytes[i] as i32 + dp[i + 1][j]).min(s2_bytes[j] as i32 + dp[i][j + 1]);
                }
            }
        }

        dp[0][0]
    }
}