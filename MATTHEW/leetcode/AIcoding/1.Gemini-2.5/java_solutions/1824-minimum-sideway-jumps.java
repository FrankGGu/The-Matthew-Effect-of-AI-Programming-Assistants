import java.util.Arrays;

class Solution {
    public int minSideJumps(int[] obstacles) {
        int n = obstacles.length;
        // dp[j] stores the minimum sideway jumps to reach the current point in lane j.
        // Lane indices are 1, 2, 3. So array size 4, index 0 is unused.
        int[] dp = new int[4];

        // Initialize for point 0
        // Frog starts at lane 2, point 0.
        // To be in lane 1 at point 0, 1 jump from lane 2.
        // To be in lane 2 at point 0, 0 jumps.
        // To be in lane 3 at point 0, 1 jump from lane 2.
        dp[1] = 1;
        dp[2] = 0;
        dp[3] = 1;

        // Use a large enough value to represent infinity, to avoid overflow issues when adding 1.
        int INF = Integer.MAX_VALUE / 2; 

        // Iterate from point 1 to n-1
        for (int i = 1; i < n; i++) {
            int[] next_dp = new int[4];
            Arrays.fill(next_dp, INF);

            // Step 1: Calculate cost of moving forward from point i-1 to point i
            // If there's an obstacle in a lane at point i, that lane is unreachable by moving forward.
            for (int j = 1; j <= 3; j++) {
                if (obstacles[i] != j) { // If lane j is not blocked at point i
                    next_dp[j] = dp[j]; // Move forward from i-1 in same lane j
                }
            }

            // Step 2: Apply sideway jumps at point i
            // This is a Bellman-Ford-like relaxation for the 3 lanes at point i.
            // Since edge weights are 1 and there are only 3 lanes (nodes),
            // two passes are sufficient to ensure all shortest paths (direct jumps) are found.
            for (int k = 0; k < 2; k++) { // Two passes for relaxation
                for (int j = 1; j <= 3; j++) { // For each target lane j
                    if (obstacles[i] != j) { // If target lane j is not blocked at point i
                        for (int other_lane = 1; other_lane <= 3; other_lane++) { // Consider jumping from other_lane
                            if (other_lane != j && obstacles[i] != other_lane) { // If source lane other_lane is not blocked
                                next_dp[j] = Math.min(next_dp[j], next_dp[other_lane] + 1);
                            }
                        }
                    }
                }
            }
            dp = next_dp; // Update dp for the next point
        }

        // The minimum jumps to reach any lane at the last point (n-1)
        return Math.min(dp[1], Math.min(dp[2], dp[3]));
    }
}