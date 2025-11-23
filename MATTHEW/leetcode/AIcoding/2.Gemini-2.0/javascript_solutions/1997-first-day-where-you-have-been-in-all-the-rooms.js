var firstDayBeenInAllRooms = function(nextVisit) {
    const n = nextVisit.length;
    const dp = new Array(n).fill(0);
    const MOD = 10**9 + 7;

    for (let i = 0; i < n - 1; i++) {
        const j = nextVisit[i];
        if (j < i) {
            dp[i + 1] = (dp[i] + 1 + (dp[i] - dp[j])) % MOD;
            if (dp[i + 1] < 0) {
                dp[i + 1] += MOD;
            }

        } else {
            dp[i + 1] = (dp[i] + 2) % MOD;
        }
    }

    return dp[n - 1];
};