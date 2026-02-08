int firstDayBeenInAllRooms(int* nextVisit, int nextVisitSize) {
    int mod = 1000000007;
    long long* dp = (long long*)malloc(nextVisitSize * sizeof(long long));
    dp[0] = 0;

    for (int i = 1; i < nextVisitSize; i++) {
        dp[i] = (2 * dp[i-1] - dp[nextVisit[i-1]] + 2 + mod) % mod;
    }

    int result = dp[nextVisitSize - 1];
    free(dp);
    return result;
}