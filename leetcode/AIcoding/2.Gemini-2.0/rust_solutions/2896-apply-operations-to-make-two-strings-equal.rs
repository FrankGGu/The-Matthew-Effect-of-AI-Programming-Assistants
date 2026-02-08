impl Solution {
    pub fn min_operations(s1: String, s2: String, x: i32) -> i32 {
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let n = s1_bytes.len();
        let mut diff_indices = Vec::new();
        for i in 0..n {
            if s1_bytes[i] != s2_bytes[i] {
                diff_indices.push(i as i32);
            }
        }

        let m = diff_indices.len();
        if m % 2 != 0 {
            return -1;
        }

        if m == 0 {
            return 0;
        }

        let mut dp = vec![0; m + 1];

        for i in 1..=m {
            dp[i] = dp[i - 1] + 1;
            if i > 1 {
                dp[i] = dp[i].min(dp[i - 2] + (diff_indices[i - 1] - diff_indices[i - 2]).min(x as i32));
            }
        }

        dp[m]
    }
}