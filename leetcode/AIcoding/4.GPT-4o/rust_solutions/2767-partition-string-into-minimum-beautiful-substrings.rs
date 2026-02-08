impl Solution {
    pub fn minimum_beautiful_substrings(s: String) -> i32 {
        let n = s.len();
        let bytes = s.as_bytes();
        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0;

        for i in 0..n {
            let mut num = 0;
            for j in i..n {
                num = (num << 1) + (bytes[j] - b'0') as i32;
                if num > 31 { break; }
                if num == 0 || num == 1 || num == 3 || num == 7 || num == 15 || num == 31 {
                    dp[j + 1] = dp[j + 1].min(dp[i] + 1);
                }
            }
        }

        if dp[n] == i32::MAX { -1 } else { dp[n] }
    }
}