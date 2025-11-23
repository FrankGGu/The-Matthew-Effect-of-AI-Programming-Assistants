pub fn pal_partition(s: String, k: i32) -> i32 {
    let n = s.len();
    let k = k as usize;
    let s: Vec<_> = s.chars().collect();

    let mut dp = vec![vec![0; n + 1]; k + 1];
    let mut pal = vec![vec![0; n]; n];

    for i in 0..n {
        pal[i][i] = 1;
    }

    for length in 2..=n {
        for i in 0..=n - length {
            let j = i + length - 1;
            if s[i] == s[j] {
                pal[i][j] = pal[i + 1][j - 1];
            } else {
                pal[i][j] = pal[i + 1][j - 1] + 1;
            }
        }
    }

    for i in 1..=k {
        for j in 0..n {
            if i == 1 {
                dp[i][j + 1] = pal[0][j];
            } else {
                for l in 0..=j {
                    dp[i][j + 1] = dp[i][j + 1].min(dp[i - 1][l] + pal[l + 1][j]);
                }
            }
        }
    }

    dp[k][n]
}