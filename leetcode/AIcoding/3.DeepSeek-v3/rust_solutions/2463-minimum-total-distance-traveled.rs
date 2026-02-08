impl Solution {
    pub fn minimum_total_distance(robot: Vec<i32>, factory: Vec<Vec<i32>>) -> i64 {
        let mut robot = robot;
        robot.sort();
        let mut factory = factory;
        factory.sort();

        let m = robot.len();
        let n = factory.len();
        let mut dp = vec![vec![std::i64::MAX; n + 1]; m + 1];
        dp[0][0] = 0;

        for j in 1..=n {
            let pos = factory[j - 1][0];
            let limit = factory[j - 1][1] as usize;
            dp[0][j] = 0;

            for i in 1..=m {
                let mut cost = 0i64;
                dp[i][j] = dp[i][j - 1];

                for k in 1..=std::cmp::min(i, limit) {
                    cost += (robot[i - k] - pos).abs() as i64;
                    if dp[i - k][j - 1] != std::i64::MAX {
                        dp[i][j] = std::cmp::min(dp[i][j], dp[i - k][j - 1] + cost);
                    }
                }
            }
        }

        dp[m][n]
    }
}