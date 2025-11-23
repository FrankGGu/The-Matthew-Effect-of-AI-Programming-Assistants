impl Solution {
    pub fn minimum_delete_sum(s1: String, s2: String) -> i32 {
        let n1 = s1.len();
        let n2 = s2.len();

        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();

        let mut total_ascii_sum: u32 = 0;
        for &b in s1_bytes {
            total_ascii_sum += b as u32;
        }
        for &b in s2_bytes {
            total_ascii_sum += b as u32;
        }

        let mut dp = vec![vec![0; n2 + 1]; n1 + 1];

        for i in 1..=n1 {
            for j in 1..=n2 {
                if s1_bytes[i - 1] == s2_bytes[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + s1_bytes[i - 1] as u32;
                } else {
                    dp[i][j] = dp[i - 1][j].max(dp[i][j - 1]);
                }
            }
        }

        let max_common_ascii_sum = dp[n1][n2];

        (total_ascii_sum - 2 * max_common_ascii_sum) as i32
    }
}