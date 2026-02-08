#include <stdio.h>
#include <stdlib.h>

int firstDayBeenInAllRooms(int* nextVisit, int nextVisitSize) {
    int* dp = (int*)malloc(nextVisitSize * sizeof(int));
    dp[0] = 0;
    for (int i = 1; i < nextVisitSize; i++) {
        dp[i] = (2 * dp[i - 1] + 1) % (1000000007);
        dp[i] = (dp[i] + nextVisit[i - 1]) % (1000000007);
    }
    int result = dp[nextVisitSize - 1];
    free(dp);
    return result;
}