pub struct Solution;

impl Solution {
    pub fn min_distance(houses: Vec<i32>, k: i32) -> i32 {
        let n = houses.len();
        let k = k as usize;
        if k >= n {
            return 0;
        }

        let mut houses = houses;
        houses.sort();

        let mut dp = vec![vec![i32::MAX; k + 1]; n + 1];
        let mut cost = vec![vec![0; n + 1]; n + 1];

        for i in 0..n {
            for j in i..n {
                cost[i][j] = (houses[i] + houses[j]) * (j as i32 - i as i32 + 1) / 2;
            }
        }

        dp[0][0] = 0;

        for i in 1..=n {
            for j in 1..=k {
                for p in 0..i {
                    dp[i][j] = dp[i][j].min(dp[p][j - 1] + cost[p][i - 1]);
                }
            }
        }

        dp[n][k]
    }
}