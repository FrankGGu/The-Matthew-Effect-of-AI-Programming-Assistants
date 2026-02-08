#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int firstDayBeenInAllRooms(int* nextVisit, int nextVisitSize) {
    int n = nextVisitSize;
    long long* dp = (long long*)malloc(n * sizeof(long long));
    dp[0] = 0;
    int mod = 1000000007;

    for (int i = 0; i < n - 1; i++) {
        long long j = nextVisit[i];
        long long diff = dp[i] - dp[j] + 1;
        if (diff < 0) {
            diff += mod;
        }
        dp[i + 1] = (dp[i] + 1 + diff) % mod;
    }

    long long result = dp[n - 1];
    free(dp);
    return (int)result;
}