#include <limits.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int minSidewayJumps(int* obstacles, int obstaclesSize) {
    int n = obstaclesSize;

    // dp[j] stores the minimum jumps to reach the current point in lane j.
    // Lane indices are 1, 2, 3. We use a 4-element array, index 0 unused.
    int dp[4];
    int next_dp[4];

    // Initialize dp for point 0
    // Frog starts at lane 2, point 0.
    // To be at lane 1 at point 0, needs 1 jump from lane 2.
    // To be at lane 2 at point 0, needs 0 jumps.
    // To be at lane 3 at point 0, needs 1 jump from lane 2.
    // Problem guarantees no obstacles at point 0.
    dp[1] = 1;
    dp[2] = 0;
    dp[3] = 1;

    // Iterate from point 1 to n-1
    for (int i = 1; i < n; ++i) {
        // Initialize next_dp for current point i
        // A large value representing infinity
        const int INF = INT_MAX / 2; 
        next_dp[1] = INF;
        next_dp[2] = INF;
        next_dp[3] = INF;

        // Step 1: Consider moving forward from previous point (i-1) to current point (i)
        // If there's an obstacle in a lane at point i, that lane is unreachable by moving forward.
        for (int j = 1; j <= 3; ++j) {
            if (obstacles[i] != j) { // No obstacle in lane j at point i
                next_dp[j] = dp[j]; // Cost is just the cost to reach i-1 in lane j
            }
        }

        // Step 2: Consider sideway jumps at current point i
        // Jumps can occur between any two lanes at the same point i.
        // We need two passes to ensure all possible jumps are considered,
        // similar to Bellman-Ford relaxation for a graph with 3 nodes.
        // A jump from lane k to lane j costs 1.

        // Pass 1 for jumps: Relax edges (jumps) once.
        for (int j = 1; j <= 3; ++j) { // Target lane j
            if (obstacles[i] != j) { // Can land in lane j
                for (int k = 1; k <= 3; ++k) { // Source lane k
                    if (k != j && obstacles[i] != k) { // Can jump from lane k
                        next_dp[j] = min(next_dp[j], next_dp[k] + 1);
                    }
                }
            }
        }

        // Pass 2 for jumps: Relax edges (jumps) a second time to propagate minimums fully.
        // This is necessary because a jump from lane A to B, then B to C, can be shorter than A to C.
        // With 3 lanes, 2 passes guarantee finding the shortest path (max 2 jumps).
        for (int j = 1; j <= 3; ++j) { // Target lane j
            if (obstacles[i] != j) { // Can land in lane j
                for (int k = 1; k <= 3; ++k) { // Source lane k
                    if (k != j && obstacles[i] != k) { // Can jump from lane k
                        next_dp[j] = min(next_dp[j], next_dp[k] + 1);
                    }
                }
            }
        }

        // Update dp for the next iteration
        dp[1] = next_dp[1];
        dp[2] = next_dp[2];
        dp[3] = next_dp[3];
    }

    // The result is the minimum jumps to reach any lane at the last point (n-1)
    return min(dp[1], min(dp[2], dp[3]));
}