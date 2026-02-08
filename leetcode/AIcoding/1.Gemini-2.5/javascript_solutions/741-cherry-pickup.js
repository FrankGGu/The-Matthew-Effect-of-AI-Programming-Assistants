var cherryPickup = function(grid) {
    const N = grid.length;
    // dp[k][r1][r2] stores the maximum cherries collected when both robots have taken 'k' steps,
    // robot 1 is at (r1, k-r1), and robot 2 is at (r2, k-r2).
    // Initialize with a very small number to represent unreachable states.
    const dp = Array(2 * N - 1).fill(0).map(() =>
        Array(N).fill(0).map(() =>
            Array(N).fill(Number.MIN_SAFE_INTEGER)
        )
    );

    // Base case: starting point (0,0) for both robots.
    // k=0, r1=0, r2=0. This implies c1=0, c2=0.
    if (grid[0][0] === -1) {
        // If the starting cell is a thorn, no cherries can be picked.
        // dp[0][0][0] remains Number.MIN_SAFE_INTEGER.
    } else {
        dp[0][0][0] = grid[0][0];
    }

    // Iterate through the total number of steps 'k'
    // 'k' ranges from 0 to 2*N - 2 (maximum steps to reach (N-1, N-1) for one robot)
    for (let k = 1; k < 2 * N - 1; k++) {
        // Iterate through possible row positions for robot 1 (r1)
        for (let r1 = 0; r1 < N; r1++) {
            // Calculate column for robot 1 (c1) based on k and r1
            const c1 = k - r1;

            // Check if c1 is within grid bounds. If not, this (r1,c1) is an invalid position.
            if (c1 < 0 || c1 >= N) {
                continue;
            }

            // Iterate through possible row positions for robot 2 (r2)
            for (let r2 = 0; r2 < N; r2++) {
                // Calculate column for robot 2 (c2) based on k and r2
                const c2 = k - r2;

                // Check if c2 is within grid bounds. If not, this (r2,c2) is an invalid position.
                if (c2 < 0 || c2 >= N) {
                    continue;
                }

                // If either robot is on a thorn (-1), this state is unreachable.
                if (grid[r1][c1] === -1 || grid[r2][c2] === -1) {
                    continue;
                }

                // Calculate cherries collected at the current state (r1,c1) and (r2,c2)
                let currentCherries = grid[r1][c1];
                // If robots are at different cells, add cherries from robot 2's cell.
                // If they are at the same cell, cherries are counted only once.
                if (r1 !== r2) {
                    currentCherries += grid[r2][c2];
                }

                // Find the maximum cherries from previous valid states (k-1)
                let maxPrevCherries = Number.MIN_SAFE_INTEGER;

                // Option 1: Both robots moved right to reach current positions.
                // Previous state: R1 at (r1, c1-1), R2 at (r2, c2-1)
                // This corresponds to dp[k-1][r1][r2]
                if (c1 > 0 && c2 > 0) {
                    maxPrevCherries = Math.max(maxPrevCherries, dp[k - 1][r1][r2]);
                }

                // Option 2: R1 moved right, R2 moved down.
                // Previous state: R1 at (r1, c1-1), R2 at (r2-1, c2)
                // This corresponds to dp[k-1][r1][r2-1]
                if (c1 > 0 && r2 > 0) {
                    maxPrevCherries = Math.max(maxPrevCherries, dp[k - 1][r1][r2 - 1]);
                }

                // Option 3: R1 moved down, R2 moved right.
                // Previous state: R1 at (r1-1, c1), R2 at (r2, c2-1)
                // This corresponds to dp[k-1][r1-1][r2]
                if (r1 > 0 && c2 > 0) {
                    maxPrevCherries = Math.max(maxPrevCherries, dp[k - 1][r1 - 1][r2]);
                }

                // Option 4: Both robots moved down.
                // Previous state: R1 at (r1-1, c1), R2 at (r2-1, c2)
                // This corresponds to dp[k-1][r1-1][r2-1]
                if (r1 > 0 && r2 > 0) {
                    maxPrevCherries = Math.max(maxPrevCherries, dp[k - 1][r1 - 1][r2 - 1]);
                }

                // If a valid previous state was found (i.e., maxPrevCherries is not MIN_SAFE_INTEGER),
                // update dp[k][r1][r2] with the sum of previous cherries and current cherries.
                if (maxPrevCherries !== Number.MIN_SAFE_INTEGER) {
                    dp[k][r1][r2] = maxPrevCherries + currentCherries;
                }
            }
        }
    }

    // The final result is the maximum cherries when both robots reach the bottom-right corner (N-1, N-1).
    // The total steps for this is (N-1) + (N-1) = 2*N - 2.
    // If dp[2*N-2][N-1][N-1] is Number.MIN_SAFE_INTEGER, it means no path exists, so return 0.
    return Math.max(0, dp[2 * N - 2][N - 1][N - 1]);
};