impl Solution {
    pub fn minimum_total_distance(robots: Vec<i32>, factories: Vec<Vec<i32>>) -> i64 {
        let mut robots = robots;
        robots.sort();
        let mut factories = factories;
        factories.sort_by(|a, b| a[0].cmp(&b[0]));

        let n = robots.len();
        let m = factories.len();

        let mut dp = vec![vec![i64::MAX; n + 1]; m + 1];
        dp[0][0] = 0;

        for i in 1..=m {
            for j in 0..=n {
                dp[i][j] = dp[i - 1][j];
                let mut cost = 0;
                let mut num = 0;
                for k in (1..=j).rev() {
                    cost += (robots[k - 1] - factories[i - 1][0]).abs() as i64;
                    num += 1;
                    if num <= factories[i - 1][1] && dp[i - 1][k - 1] != i64::MAX {
                        dp[i][j] = dp[i][j].min(dp[i - 1][k - 1] + cost);
                    }
                }
            }
        }

        dp[m][n]
    }
}