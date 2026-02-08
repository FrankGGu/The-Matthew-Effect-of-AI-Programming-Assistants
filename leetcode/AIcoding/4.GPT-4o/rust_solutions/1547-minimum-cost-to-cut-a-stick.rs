impl Solution {
    pub fn min_cost(n: i32, cuts: Vec<i32>) -> i32 {
        let mut cuts = cuts;
        cuts.sort();
        let cuts = cuts;
        let mut dp = vec![vec![0; cuts.len() + 2]; cuts.len() + 2];
        let mut positions = vec![0];
        positions.extend(cuts);
        positions.push(n);

        for length in 2..=cuts.len() + 1 {
            for left in 0..=cuts.len() + 1 - length {
                let right = left + length;
                dp[left][right] = i32::MAX;
                for k in left + 1..right {
                    dp[left][right] = dp[left][right].min(dp[left][k] + dp[k][right] + positions[right] - positions[left]);
                }
            }
        }

        dp[0][cuts.len() + 1]
    }
}