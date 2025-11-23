function firstDayBeenInAllRooms(prevDailyVisits) {
    const MOD = 1e9 + 7;
    const n = prevDailyVisits.length;
    let dp = new Array(n).fill(0);
    dp[0] = 0;

    for (let i = 1; i < n; i++) {
        dp[i] = (dp[i - 1] + prevDailyVisits[i - 1]) % MOD;
    }

    return dp.reduce((acc, val) => (acc + val) % MOD, 0);
}