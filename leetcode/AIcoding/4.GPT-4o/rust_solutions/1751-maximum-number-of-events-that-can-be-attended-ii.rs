use std::cmp::max;

pub fn max_value(events: Vec<Vec<i32>>, k: i32) -> i32 {
    let n = events.len();
    let mut dp = vec![vec![0; (k + 1) as usize]; n + 1];
    let mut ends = events.clone();
    ends.sort_unstable_by_key(|e| e[1]);

    for i in 1..=n {
        for j in 1..=k {
            dp[i][j] = dp[i - 1][j];
            let mut last = 0;
            for l in (0..i).rev() {
                if ends[l][1] < ends[i - 1][0] {
                    last = l + 1;
                    break;
                }
            }
            dp[i][j] = max(dp[i][j], dp[last][j - 1] + ends[i - 1][2]);
        }
    }

    dp[n][k]
}