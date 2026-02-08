pub fn minimum_distance(word: String) -> i32 {
    let word: Vec<char> = word.chars().collect();
    let n = word.len();
    let mut dp = vec![vec![vec![i32::MAX; 26]; 26]; n + 1];
    dp[0][26][26] = 0;

    for i in 0..n {
        let c = word[i] as usize - 'A' as usize;
        for j in 0..27 {
            for k in 0..27 {
                if dp[i][j][k] != i32::MAX {
                    dp[i + 1][c][j] = dp[i + 1][c][j].min(dp[i][j][k] + if k == 26 { 1 } else { 1 + (i32::abs(c as i32 - k as i32)) });
                    dp[i + 1][j][c] = dp[i + 1][j][c].min(dp[i][j][k] + if j == 26 { 1 } else { 1 + (i32::abs(c as i32 - j as i32)) });
                }
            }
        }
    }

    let mut result = i32::MAX;
    for j in 0..27 {
        for k in 0..27 {
            result = result.min(dp[n][j][k]);
        }
    }

    result
}