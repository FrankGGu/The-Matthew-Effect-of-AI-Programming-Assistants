#include <stdio.h>
#include <stdlib.h>

int minJump(int* home, int homeSize, int* one, int oneSize, int* two, int twoSize) {
    int maxHome = home[0];
    for (int i = 1; i < homeSize; i++) {
        if (home[i] > maxHome) {
            maxHome = home[i];
        }
    }

    int* dp = (int*)malloc((maxHome + 1) * sizeof(int));
    for (int i = 0; i <= maxHome; i++) {
        dp[i] = -1;
    }

    dp[0] = 0;

    for (int i = 0; i <= maxHome; i++) {
        if (dp[i] == -1) continue;

        for (int j = 0; j < oneSize; j++) {
            int next = i + one[j];
            if (next <= maxHome && (dp[next] == -1 || dp[next] > dp[i] + 1)) {
                dp[next] = dp[i] + 1;
            }
        }

        for (int j = 0; j < twoSize; j++) {
            int next = i + two[j];
            if (next <= maxHome && (dp[next] == -1 || dp[next] > dp[i] + 1)) {
                dp[next] = dp[i] + 1;
            }
        }
    }

    int result = dp[home[0]];
    free(dp);
    return result;
}