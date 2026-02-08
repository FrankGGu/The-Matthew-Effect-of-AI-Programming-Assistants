impl Solution {
    pub fn minimum_cost(cuts: Vec<i32>, n: i32) -> i32 {
        let mut cuts = cuts;
        cuts.sort();
        let mut dp = vec![vec![0; cuts.len() + 2]; cuts.len() + 2];
        let mut cuts = vec![0].into_iter().chain(cuts.into_iter()).chain(vec![n]).collect::<Vec<_>>();

        for length in 2..=cuts.len() {
            for i in 0..cuts.len() - length {
                let j = i + length;
                dp[i][j] = (cuts[j] - cuts[i]) + (0..length - 1).map(|k| dp[i][i + k + 1] + dp[i + k + 1][j]).min().unwrap_or(0);
            }
        }
        dp[0][cuts.len() - 1]
    }
}