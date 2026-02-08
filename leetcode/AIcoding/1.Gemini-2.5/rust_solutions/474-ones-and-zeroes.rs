impl Solution {
    pub fn find_max_form(strs: Vec<String>, m: i32, n: i32) -> i32 {
        let mut dp = vec![vec![0; (n + 1) as usize]; (m + 1) as usize];

        for s in strs {
            let mut zeros = 0;
            let mut ones = 0;
            for c in s.chars() {
                if c == '0' {
                    zeros += 1;
                } else {
                    ones += 1;
                }
            }

            for i in (zeros..=m).rev() {
                for j in (ones..=n).rev() {
                    dp[i as usize][j as usize] = dp[i as usize][j as usize]
                        .max(1 + dp[(i - zeros) as usize][(j - ones) as usize]);
                }
            }
        }

        dp[m as usize][n as usize]
    }
}