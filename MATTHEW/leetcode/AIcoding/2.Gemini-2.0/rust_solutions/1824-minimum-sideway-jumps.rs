impl Solution {
    pub fn min_side_jumps(obstacles: Vec<i32>) -> i32 {
        let n = obstacles.len();
        let mut dp = vec![std::i32::MAX; 3];
        dp[1] = 0;

        for i in 1..n {
            let obs = obstacles[i] as usize;
            let mut next_dp = vec![std::i32::MAX; 3];

            for lane in 0..3 {
                if lane + 1 == obs {
                    continue;
                }

                next_dp[lane] = dp[lane];
            }

            for lane in 0..3 {
                if lane + 1 == obs {
                    continue;
                }

                for prev_lane in 0..3 {
                    if prev_lane + 1 == obstacles[i] as usize || prev_lane == lane {
                        continue;
                    }

                    if next_dp[lane] > dp[prev_lane] + 1 {
                        next_dp[lane] = dp[prev_lane] + 1;
                    }
                }
            }

            dp = next_dp;
        }

        *dp.iter().min().unwrap()
    }
}