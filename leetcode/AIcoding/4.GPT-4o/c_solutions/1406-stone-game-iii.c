#include <stdio.h>
#include <string.h>
#include <limits.h>

#define MAXN 100

int dp[MAXN + 1];

char* stoneGameIII(int* stoneValue, int stoneValueSize) {
    memset(dp, 0, sizeof(dp));
    dp[stoneValueSize] = 0;

    for (int i = stoneValueSize - 1; i >= 0; i--) {
        int maxVal = INT_MIN;
        int sum = 0;
        for (int j = 0; j < 3 && i + j < stoneValueSize; j++) {
            sum += stoneValue[i + j];
            maxVal = (maxVal > sum - dp[i + j + 1]) ? maxVal : (sum - dp[i + j + 1]);
        }
        dp[i] = maxVal;
    }

    if (dp[0] > 0) return "Alice";
    else if (dp[0] < 0) return "Bob";
    return "Tie";
}