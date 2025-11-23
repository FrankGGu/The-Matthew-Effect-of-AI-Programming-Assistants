impl Solution {
    pub fn can_reach(s: String, min_jump: i32, max_jump: i32) -> bool {
        let s = s.as_bytes();
        let n = s.len();
        let min_jump = min_jump as usize;
        let max_jump = max_jump as usize;
        let mut dp = vec![false; n];
        dp[0] = s[0] == b'0';
        let mut pre = 0;

        for i in 1..n {
            if i >= min_jump && dp[i - min_jump] {
                pre += 1;
            }
            if i > max_jump && dp[i - max_jump - 1] {
                pre -= 1;
            }
            dp[i] = pre > 0 && s[i] == b'0';
        }

        dp[n - 1]
    }
}