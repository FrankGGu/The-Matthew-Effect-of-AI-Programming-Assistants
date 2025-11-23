impl Solution {
    pub fn min_side_jumps(obstacles: Vec<i32>) -> i32 {
        let n = obstacles.len();
        let mut dp = vec![vec![i32::MAX; 3]; n];
        dp[0][0] = 1;
        dp[0][1] = 0;
        dp[0][2] = 1;

        for i in 1..n {
            for lane in 0..3 {
                if obstacles[i] == lane + 1 {
                    continue;
                }
                let mut min_jumps = dp[i-1][lane];
                for other_lane in 0..3 {
                    if other_lane == lane || obstacles[i] == other_lane + 1 {
                        continue;
                    }
                    if dp[i-1][other_lane] != i32::MAX {
                        min_jumps = min_jumps.min(dp[i-1][other_lane] + 1);
                    }
                }
                dp[i][lane] = min_jumps;
            }
        }

        *dp[n-1].iter().min().unwrap()
    }
}