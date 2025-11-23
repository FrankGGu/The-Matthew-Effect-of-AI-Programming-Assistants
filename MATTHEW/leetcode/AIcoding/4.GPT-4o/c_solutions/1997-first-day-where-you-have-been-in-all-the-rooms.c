int firstDayBeenInAllRooms(int* nextVisit, int nextVisitSize) {
    long long MOD = 1e9 + 7;
    long long dp[nextVisitSize];
    dp[0] = 0;
    for (int i = 1; i < nextVisitSize; i++) {
        dp[i] = (dp[i - 1] * 2 + 2) % MOD;
    }
    long long result = 0;
    for (int i = 0; i < nextVisitSize - 1; i++) {
        result = (result + dp[i]) % MOD;
    }
    return (int)result;
}