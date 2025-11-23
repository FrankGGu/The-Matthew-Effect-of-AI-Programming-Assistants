impl Solution {
    pub fn find_max_form(strs: Vec<String>, m: i32, n: i32) -> i32 {
        let mut dp = vec![vec![0; (n + 1) as usize]; (m + 1) as usize];

        for s in strs {
            let (zeros, ones) = s.chars().fold((0, 0), |(z, o), c| {
                if c == '0' { (z + 1, o) } else { (z, o + 1) }
            });

            for i in (zeros..=m).rev() {
                for j in (ones..=n).rev() {
                    dp[i as usize][j as usize] = dp[i as usize][j as usize].max(dp[(i - zeros) as usize][(j - ones) as usize] + 1);
                }
            }
        }

        dp[m as usize][n as usize]
    }
}