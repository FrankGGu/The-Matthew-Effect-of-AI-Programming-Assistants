func buildArray(n int, m int, k int) int {
    const MOD = 1_000_000_007

    // dp[i][j][c] represents the number of ways to build an array of length i,
    // where the maximum element is j, and the search cost is