impl Solution {
    pub fn min_sideway_jumps(obstacles: Vec<i32>) -> i32 {
        let n = obstacles.len();
        // Use a large enough value to represent infinity.
        // i32::MAX / 2 is safe from overflow when adding 1.
        let infinity = i32::MAX / 2;

        // dp[j] stores the minimum jumps to reach the current point on lane j.
        // dp[0] is unused; lanes are 1, 2, 3.
        let mut dp = vec![infinity; 4];

        // Initial state at point 0:
        // Frog starts at lane 2 with 0 jumps.
        // To reach lane 1 or 3 at point 0, it takes 1 jump (from lane 2).
        dp[1] = 1;
        dp[2] = 0;
        dp[3] = 1;

        // Iterate through points from 1 to n-1
        for i in 1..n {
            let mut new_dp = vec![infinity; 4];

            // Step 1: Calculate new_dp based on moving straight from (i-1) to (i).
            // If there's an obstacle at point i on a lane, it cannot be reached by moving straight.
            for lane in 1..=3 {
                if obstacles[i] as usize != lane { // Check if the current lane is not blocked at point i
                    new_dp[lane] = dp[lane];
                }
            }

            // Step 2: Apply sideway jumps at point i.
            // A sideway jump costs 1. We can jump between any two unblocked lanes at point i.
            // Since there are only 3 lanes, two relaxation passes are sufficient to propagate
            // all possible single and double jumps (e.g., 1->2, 1->3, 2->1, 2->3, 3->1, 3->2).
            // This is analogous to a Bellman-Ford relaxation step on the 3-node graph of lanes.
            for _ in 0..2 { // Perform relaxation twice
                for lane in 1..=3 {
                    if obstacles[i] as usize != lane { // Only update if target lane is not blocked at point i
                        for other_lane in 1..=3 {
                            if lane != other_lane && obstacles[i] as usize != other_lane { // Source lane must also not be blocked
                                new_dp[lane] = new_dp[lane].min(new_dp[other_lane] + 1);
                            }
                        }
                    }
                }
            }
            dp = new_dp;
        }

        // The minimum jumps to reach any lane at the final point (n-1).
        *dp[1..=3].iter().min().unwrap()
    }
}