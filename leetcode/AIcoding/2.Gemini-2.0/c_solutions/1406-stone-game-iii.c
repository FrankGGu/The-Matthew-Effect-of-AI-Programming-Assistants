#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int stoneGameIII(int* stoneValue, int stoneValueSize) {
    int dp[stoneValueSize + 1];
    dp[stoneValueSize] = 0;

    for (int i = stoneValueSize - 1; i >= 0; i--) {
        dp[i] = INT_MIN;
        int sum = 0;
        for (int j = i; j < stoneValueSize && j < i + 3; j++) {
            sum += stoneValue[j];
            int nextScore = (j + 1 < stoneValueSize) ? dp[j + 1] : 0;
            dp[i] = (dp[i] > sum - nextScore) ? dp[i] : sum - nextScore;
        }
    }

    if (dp[0] > 0) {
        return 1; // "Alice"
    } else if (dp[0] < 0) {
        return -1; // "Bob"
    } else {
        return 0; // "Tie"
    }
}