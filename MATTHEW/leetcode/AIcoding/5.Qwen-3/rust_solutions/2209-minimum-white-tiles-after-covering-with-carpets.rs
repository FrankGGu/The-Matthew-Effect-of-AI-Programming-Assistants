impl Solution {
    pub fn minimum_white_tiles(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let k = k as usize;
        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            dp[i] = dp[i - 1] + (if s[i - 1] == b'w' { 1 } else { 0 });
        }

        let mut max_cover = 0;
        for i in 0..=n {
            for j in i..=n {
                if j - i > k {
                    break;
                }
                let cover = dp[j] - dp[i];
                max_cover = max_cover.max(cover);
            }
        }

        dp[n] - max_cover
    }
}