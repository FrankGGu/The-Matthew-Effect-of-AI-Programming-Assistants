var numWays = function(n, relation, k) {
    // dp[s][p] represents the number of ways to reach player 'p' in 's' steps.
    // Initialize dp table with (k+1) rows and n columns, all zeros.
    const dp = Array(k + 1).fill(0).map(() => Array(n).fill(0));

    // Base case: There is 1 way to be at player 0 in 0 steps.
    dp[0][0] = 1;

    // Build an adjacency list for efficient lookup of relations.
    const adj = Array(n).fill(0).map(() => []);
    for (const [from, to] of relation) {
        adj[from].push(to);
    }

    // Iterate through steps from 0 to k-1
    for (let s = 0; s < k; s++) {
        // Iterate through each player
        for (let p = 0; p < n; p++) {
            // If there are ways to reach player 'p' in 's' steps
            if (dp[s][p] > 0) {
                // For each neighbor of player 'p'
                for (const neighbor of adj[p]) {
                    // Add the number of ways to reach 'p' in 's' steps
                    // to the number of ways to reach 'neighbor' in 's+1' steps.
                    dp[s + 1][neighbor] += dp[s][p];
                }
            }
        }
    }

    // The result is the number of ways to reach player n-1 in exactly k steps.
    return dp[k][n - 1];
};