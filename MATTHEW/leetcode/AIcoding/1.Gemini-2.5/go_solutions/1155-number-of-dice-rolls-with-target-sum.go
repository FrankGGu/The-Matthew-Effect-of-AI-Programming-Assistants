func numRollsToTarget(n int, f int, target int) int {
    const MOD = 1e9 + 7

    // dp[j] represents the number of ways to achieve sum 'j' with the current number of dice.
    // We use a 1D DP array to optimize space, as dp[i