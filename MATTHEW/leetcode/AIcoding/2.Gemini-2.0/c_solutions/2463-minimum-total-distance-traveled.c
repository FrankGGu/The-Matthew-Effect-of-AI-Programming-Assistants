#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

long long minTotalDistance(int* robots, int robotsSize, int** factories, int factoriesSize, int* factoriesColSize) {
    qsort(robots, robotsSize, sizeof(int), compare);

    long long dp[robotsSize + 1][factoriesSize + 1];

    for (int i = 0; i <= robotsSize; i++) {
        for (int j = 0; j <= factoriesSize; j++) {
            dp[i][j] = -1;
        }
    }

    dp[0][0] = 0;

    for (int i = 0; i <= robotsSize; i++) {
        for (int j = 1; j <= factoriesSize; j++) {
            if (dp[i][j - 1] != -1) {
                dp[i][j] = dp[i][j - 1];
            }

            long long cost = 0;
            int count = 0;
            for (int k = i - 1; k >= 0 && count < factories[j - 1][1]; k--) {
                cost += abs(robots[k] - factories[j - 1][0]);
                count++;
                if (dp[k][j - 1] != -1) {
                    if (dp[i][j] == -1 || dp[k][j - 1] + cost < dp[i][j]) {
                        dp[i][j] = dp[k][j - 1] + cost;
                    }
                }
            }
        }
    }

    return dp[robotsSize][factoriesSize];
}