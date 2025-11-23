func numberOfStableArrays(zeroes int, ones int, limit0 int, limit1 int) int {
    const MOD = 1_000_000_007

    // dp[i][last_val][count] stores the number of stable arrays of length i
    // ending with `last_val` (