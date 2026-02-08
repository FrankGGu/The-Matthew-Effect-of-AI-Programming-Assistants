pub fn min_cost(n: i32, cuts: Vec<i32>) -> i32 {
    let mut cuts = cuts;
    cuts.sort();
    let mut dp = vec![vec![0; cuts.len() + 2]; cuts.len() + 2];
    let cuts_len = cuts.len();
    for length in 1..=cuts_len {
        for i in 0..=cuts_len - length {
            let j = i + length + 1;
            dp[i][j] = std::i32::MAX;
            for k in i + 1..j {
                dp[i][j] = dp[i][j].min(dp[i][k] + dp[k][j] + cuts[j - 1] - cuts[i]);
            }
        }
    }
    dp[0][cuts_len + 1]
}