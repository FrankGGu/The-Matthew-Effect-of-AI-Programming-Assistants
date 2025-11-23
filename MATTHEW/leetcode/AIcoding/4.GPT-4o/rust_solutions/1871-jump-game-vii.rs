impl Solution {
    pub fn can_reach(s: String, min_jump: i32, max_jump: i32) -> bool {
        let n = s.len();
        let mut dp = vec![false; n];
        dp[0] = true;
        let mut max_reach = 0;

        for i in 0..n {
            if i > 0 {
                if i as i32 >= min_jump {
                    max_reach += dp[i - min_jump as usize] as i32;
                }
                if i as i32 > max_jump {
                    max_reach -= dp[i - max_jump as usize - 1] as i32;
                }
            }
            if max_reach > 0 && s.chars().nth(i).unwrap() == '0' {
                dp[i] = true;
            }
        }

        dp[n - 1]
    }
}