pub fn min_changes(s: String, k: i32) -> i32 {
    let n = s.len();
    let k = k as usize;
    let mut dp = vec![vec![i32::MAX; k + 1]; n + 1];
    dp[0][0] = 0;

    for i in 0..n {
        for j in 0..=k {
            if dp[i][j] < i32::MAX {
                let mut freq = vec![0; 26];
                let mut changes = 0;

                for l in i..n {
                    freq[(s[l] as u8 - b'a') as usize] += 1;
                    let most_freq = *freq.iter().max().unwrap();
                    let len = l - i + 1;
                    changes = len - most_freq;

                    if j + 1 <= k {
                        dp[l + 1][j + 1] = dp[l + 1][j + 1].min(dp[i][j] + changes);
                    }
                }
            }
        }
    }

    let mut result = i32::MAX;
    for j in 1..=k {
        result = result.min(dp[n][j]);
    }

    result
}