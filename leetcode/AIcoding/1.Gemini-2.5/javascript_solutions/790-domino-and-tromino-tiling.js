var numTilings = function(n) {
    const MOD = 10**9 + 7;

    if (n === 1) {
        return 1;
    }
    if (n === 2) {
        return 2;
    }

    const dp = new Array(n + 1);

    // dp[i] represents the number of ways to tile a 2xi board
    // Base cases
    dp[0] = 1; // Represents an empty board, one way to tile (do nothing)
    dp[1] = 1; // One vertical domino
    dp[2] = 2; // Two vertical dominos, or two horizontal dominos

    // Recurrence relation: dp[i] = 2 * dp[i-1] + dp[i-3]
    // This recurrence is derived from a system of two recurrences:
    // f[i] = f[i-1] + f[i-2] + 2 * g[i-1]
    // g[i] = g[i-1] + f[i-1]
    // where f[i] is the number of ways to tile a 2xi board completely,
    // and g[i] is the number of ways to tile a 2xi board with one square missing at the top-right (or bottom-right).
    // Substituting g[i-1] from the second into the first and simplifying yields the single recurrence.
    for (let i = 3; i <= n; i++) {
        dp[i] = (2 * dp[i-1] + dp[i-3]) % MOD;
    }

    return dp[n];
};