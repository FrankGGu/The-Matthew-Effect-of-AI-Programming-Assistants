class Solution {
    public int cherryPickup(int[][] grid) {
        int N = grid.length;
        // dp[k][r1][r2] stores the maximum cherries collected
        // when both robots have taken 'k' steps,
        // robot 1 is at (r1, k - r1), and robot 2 is at (r2, k - r2).
        // k ranges from 0 to 2*(N-1)
        // r1, r2 range from 0 to N-1
        int[][][] dp = new int[2 * N - 1][N][N];

        // Initialize dp table with a value indicating an unreachable state.
        // Integer.MIN_VALUE is used because cherry counts are non-negative,
        // so any valid path will result in a value greater than MIN_VALUE.
        for (int i = 0; i < 2 * N - 1; i++) {
            for (int j = 0; j < N; j++) {
                for (int l = 0; l < N; l++) {
                    dp[i][j][l] = Integer.MIN_VALUE;
                }
            }
        }

        // Base case: both robots start at (0,0)
        // k=0, r1=0, r2=0 => c1=0, c2=0
        if (grid[0][0] == -1) {
            // Starting cell is a thorn, no cherries can be collected.
            // The problem statement implies we return 0 in this case.
            return 0;
        }
        dp[0][0][0] = grid[0][0];

        // Iterate through the number of steps 'k'
        // k goes from 1 up to 2*(N-1) (total steps to reach (N-1, N-1))
        for (int k = 1; k < 2 * N - 1; k++) {
            // Iterate through possible row positions for robot 1 (r1)
            for (int r1 = 0; r1 < N; r1++) {
                // Calculate column position for robot 1 (c1)
                int c1 = k - r1;

                // Check if c1 is within grid boundaries
                if (c1 < 0 || c1 >= N) {
                    continue;
                }

                // Check if robot 1's current cell is a thorn
                if (grid[r1][c1] == -1) {
                    continue;
                }

                // Iterate through possible row positions for robot 2 (r2)
                for (int r2 = 0; r2 < N; r2++) {
                    // Calculate column position for robot 2 (c2)
                    int c2 = k - r2;

                    // Check if c2 is within grid boundaries
                    if (c2 < 0 || c2 >= N) {
                        continue;
                    }

                    // Check if robot 2's current cell is a thorn
                    if (grid[r2][c2] == -1) {
                        continue;
                    }

                    // Calculate cherries collected at the current cells (r1,c1) and (r2,c2)
                    int currentCherries = grid[r1][c1];
                    // If robots are at different cells, add cherries from robot 2's cell
                    // Otherwise, the cherry at (r1,c1) has already been counted.
                    if (r1 != r2 || c1 != c2) {
                        currentCherries += grid[r2][c2];
                    }

                    // Find the maximum cherries from previous states (k-1 steps)
                    int maxPrevCherries = Integer.MIN_VALUE;

                    // There are 4 possible ways to reach (r1,c1) and (r2,c2) from (k-1) steps:
                    // 1. Robot 1 moved down (from r1-1, c1), Robot 2 moved down (from r2-1, c2)
                    if (r1 > 0 && r2 > 0 && dp[k - 1][r1 - 1][r2 - 1] != Integer.MIN_VALUE) {
                        maxPrevCherries = Math.max(maxPrevCherries, dp[k - 1][r1 - 1][r2 - 1]);
                    }
                    // 2. Robot 1 moved down (from r1-1, c1), Robot 2 moved right (from r2, c2-1)
                    if (r1 > 0 && c2 > 0 && dp[k - 1][r1 - 1][r2] != Integer.MIN_VALUE) {
                        maxPrevCherries = Math.max(maxPrevCherries, dp[k - 1][r1 - 1][r2]);
                    }
                    // 3. Robot 1 moved right (from r1, c1-1), Robot 2 moved down (from r2-1, c2)
                    if (c1 > 0 && r2 > 0 && dp[k - 1][r1][r2 - 1] != Integer.MIN_VALUE) {
                        maxPrevCherries = Math.max(maxPrevCherries, dp[k - 1][r1][r2 - 1]);
                    }
                    // 4. Robot 1 moved right (from r1, c1-1), Robot 2 moved right (from r2, c2-1)
                    if (c1 > 0 && c2 > 0 && dp[k - 1][r1][r2] != Integer.MIN_VALUE) {
                        maxPrevCherries = Math.max(maxPrevCherries, dp[k - 1][r1][r2]);
                    }

                    // If a valid previous state was found, update the current dp state
                    if (maxPrevCherries != Integer.MIN_VALUE) {
                        dp[k][r1][r2] = maxPrevCherries + currentCherries;
                    }
                }
            }
        }

        // The final answer is the maximum cherries collected when both robots reach (N-1, N-1).
        // This corresponds to k = 2*(N-1), r1 = N-1, r2 = N-1.
        int result = dp[2 * N - 2][N - 1][N - 1];

        // If the destination (N-1, N-1) is unreachable (result is still Integer.MIN_VALUE),
        // it means no valid path exists, so return 0 as per problem requirements.
        return Math.max(0, result);
    }
}