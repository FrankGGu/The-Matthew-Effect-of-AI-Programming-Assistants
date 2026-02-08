impl Solution {
    pub fn min_distance(houses: Vec<i32>, k: i32) -> i32 {
        let n = houses.len();
        let k = k as usize;
        let mut houses = houses;
        houses.sort();

        let mut cost = vec![vec![0; n]; n];
        for i in 0..n {
            for j in i + 1..n {
                let mut median = houses[(i + j) / 2];
                for l in i..=j {
                    cost[i][j] += (houses[l] - median).abs();
                }
            }
        }

        let mut dp = vec![vec![i32::MAX; k + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 1..=k.min(i) {
                for l in 1..=i {
                    if dp[l - 1][j - 1] != i32::MAX {
                        dp[i][j] = dp[i][j].min(dp[l - 1][j - 1] + cost[l - 1][i - 1]);
                    }
                }
            }
        }

        dp[n][k]
    }
}