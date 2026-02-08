var firstDayBeenInAllRooms = function(nextVisit) {
    const MOD = 1e9 + 7;
    const n = nextVisit.length;
    const dp = new Array(n).fill(0);
    for (let i = 1; i < n; i++) {
        dp[i] = (2 * dp[i - 1] - dp[nextVisit[i - 1]] + 2 + MOD) % MOD;
    }
    return dp[n - 1];
};