impl Solution {
    pub fn find_max_form(strs: Vec<String>, m: i32, n: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for s in strs {
            let zeros = s.chars().filter(|&c| c == '0').count();
            let ones = s.len() - zeros;

            for i in (zeros..=m).rev() {
                for j in (ones..=n).rev() {
                    dp[i][j] = dp[i][j].max(dp[i - zeros][j - ones] + 1);
                }
            }
        }

        dp[m][n]
    }
}