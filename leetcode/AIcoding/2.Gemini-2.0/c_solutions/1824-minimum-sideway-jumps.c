#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSideJumps(int* obstacles, int obstaclesSize) {
    int dp[3];
    dp[0] = 1;
    dp[1] = 0;
    dp[2] = 1;

    for (int i = 0; i < obstaclesSize; i++) {
        int obs = obstacles[i] - 1;
        if (obs != -1) {
            dp[obs] = INT_MAX;
        }

        int minVal = INT_MAX;
        for (int j = 0; j < 3; j++) {
            if (dp[j] < minVal) {
                minVal = dp[j];
            }
        }

        for (int j = 0; j < 3; j++) {
            if (dp[j] != INT_MAX) {
                dp[j] = minVal;
            }
        }

        if (dp[0] > dp[1] + 1) dp[0] = dp[1] + 1;
        if (dp[0] > dp[2] + 1) dp[0] = dp[2] + 1;
        if (dp[1] > dp[0] + 1) dp[1] = dp[0] + 1;
        if (dp[1] > dp[2] + 1) dp[1] = dp[2] + 1;
        if (dp[2] > dp[0] + 1) dp[2] = dp[0] + 1;
        if (dp[2] > dp[1] + 1) dp[2] = dp[1] + 1;
    }

    int res = INT_MAX;
    for (int i = 0; i < 3; i++) {
        if (dp[i] < res) {
            res = dp[i];
        }
    }

    return res;
}