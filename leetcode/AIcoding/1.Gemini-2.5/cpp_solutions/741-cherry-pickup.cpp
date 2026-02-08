#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int cherryPickup(std::vector<std::vector<int>>& grid) {
        int N = grid.size();

        // dp[k][r1][r2] stores the maximum cherries collected when:
        // both robots have taken 'k' steps (total steps from (0,0) for each robot)
        // robot 1 is at (r1, k - r1)
        // robot 2 is at (r2, k - r2)
        // The column coordinates are c1 = k - r1 and c2 = k - r2.
        // The maximum value for k is 2 * (N - 1).
        std::vector<std::vector<std::vector<int>>> dp(
            2 * N, std::vector<std::vector<int>>(N, std::vector<int>(N, std::numeric_limits<int>::min())));

        // Base case: Both robots start at (0,0).
        // k=0, r1=0, r2=0.
        // c1 = 0-0 = 0, c2 = 0-0 = 0.
        if (grid[0][0] == -1) {
            return 0; // Cannot start, so 0 cherries.
        }
        dp[0][0][0] = grid[0][0];

        // Iterate through the total number of steps 'k'
        for (int k = 1; k <= 2 * (N - 1); ++k) {
            // Iterate through possible row positions for robot 1
            for (int r1 = 0; r1 < N; ++r1) {
                int c1 = k - r1; // Calculate column for robot 1

                // Check if robot 1's position is valid (within grid boundaries and not a thorn)
                if (c1 < 0 || c1 >= N || grid[r1][c1] == -1) {
                    continue;
                }

                // Iterate through possible row positions for robot 2
                for (int r2 = 0; r2 < N; ++r2) {
                    int c2 = k - r2; // Calculate column for robot 2

                    // Check if robot 2's position is valid (within grid boundaries and not a thorn)
                    if (c2 < 0 || c2 >= N || grid[r2][c2] == -1) {
                        continue;
                    }

                    // Calculate cherries at the current positions
                    int current_cherries = grid[r1][c1];
                    if (r1 != r2 || c1 != c2) { // If robots are at different cells, add cherries from both
                        current_cherries += grid[r2][c2];
                    }

                    // Find the maximum cherries from previous valid states
                    int max_prev_val = std::numeric_limits<int>::min();

                    // Option 1: Both robots moved down (R1 from (r1-1, c1), R2 from (r2-1, c2))
                    if (r1 > 0 && r2 > 0 && dp[k - 1][r1 - 1][r2 - 1] != std::numeric_limits<int>::min()) {
                        max_prev_val = std::max(max_prev_val, dp[k - 1][r1 - 1][r2 - 1]);
                    }

                    // Option 2: Robot 1 moved down (R1 from (r1-1, c1)), Robot 2 moved right (R2 from (r2, c2-1))
                    if (r1 > 0 && c2 > 0 && dp[k - 1][r1 - 1][r2] != std::numeric_limits<int>::min()) {
                        max_prev_val = std::max(max_prev_val, dp[k - 1][r1 - 1][r2]);
                    }

                    // Option 3: Robot 1 moved right (R1 from (r1, c1-1)), Robot 2 moved down (R2 from (r2-1, c2))
                    if (c1 > 0 && r2 > 0 && dp[k - 1][r1][r2 - 1] != std::numeric_limits<int>::min()) {
                        max_prev_val = std::max(max_prev_val, dp[k - 1][r1][r2 - 1]);
                    }

                    // Option 4: Both robots moved right (R1 from (r1, c1-1), R2 from (r2, c2-1))
                    if (c1 > 0 && c2 > 0 && dp[k - 1][r1][r2] != std::numeric_limits<int>::min()) {
                        max_prev_val = std::max(max_prev_val, dp[k - 1][r1][r2]);
                    }

                    // If a valid previous state was found, update the current state
                    if (max_prev_val != std::numeric_limits<int>::min()) {
                        dp[k][r1][r2] = max_prev_val + current_cherries;
                    }
                }
            }
        }

        // The final answer is the maximum cherries collected when both robots reach (N-1, N-1).
        // This corresponds to k = 2 * (N - 1), r1 = N - 1, r2 = N - 1.
        // If this state is unreachable (value is INT_MIN), it means no path exists, so return 0.
        return std::max(0, dp[2 * (N - 1)][N - 1][N - 1]);
    }
};