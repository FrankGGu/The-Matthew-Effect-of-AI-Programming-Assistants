var minSideJumps = function(obstacles) {
    const N = obstacles.length;
    const INF = Number.MAX_SAFE_INTEGER;

    // dp[j] stores the minimum sideway jumps to reach the current point in lane j.
    // Index 0 is unused, lanes are 1, 2, 3.
    // Initial state at point 0:
    // Start in lane 2 with 0 jumps.
    // To be in lane 1 or 3 at point 0, one jump is needed from lane 2.
    let dp = [INF, 1, 0, 1];

    // Iterate from point 0 to N-2 (calculating costs for point 1 to N-1)
    for (let i = 0; i < N - 1; i++) {
        const nextPointObstacle = obstacles[i + 1];
        let next_dp = [INF, INF, INF, INF]; // Minimum jumps to reach point i+1

        // Step 1: Calculate costs for moving straight from point i to point i+1.
        // This is only possible if there is no obstacle at (i+1, lane).
        for (let lane = 1; lane <= 3; lane++) {
            if (nextPointObstacle !== lane) {
                next_dp[lane] = dp[lane];
            }
        }

        // Step 2: Apply jumps at point i+1.
        // A jump from lane k to lane j at point i+1 costs 1.
        // This needs to be done iteratively to ensure all transitive jumps are considered.
        // Two passes are sufficient for 3 lanes.
        for (let pass = 0; pass < 2; pass++) {
            for (let lane = 1; lane <= 3; lane++) {
                if (nextPointObstacle !== lane) { // Target lane must be clear at i+1
                    for (let k = 1; k <= 3; k++) {
                        if (k !== lane && nextPointObstacle !== k) { // Source lane must also be clear at i+1
                            next_dp[lane] = Math.min(next_dp[lane], next_dp[k] + 1);
                        }
                    }
                }
            }
        }

        // Update dp for the next iteration (point i+1 becomes the current point)
        dp = next_dp;
    }

    // The final answer is the minimum of dp[1], dp[2], dp[3] at the last point (N-1).
    return Math.min(dp[1], dp[2], dp[3]);
};