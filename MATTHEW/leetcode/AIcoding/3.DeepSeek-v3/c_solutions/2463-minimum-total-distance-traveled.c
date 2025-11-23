#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

long long minimumTotalDistance(int* robot, int robotSize, int** factory, int factorySize, int* factoryColSize) {
    qsort(robot, robotSize, sizeof(int), cmp);

    int* factories = malloc(factorySize * sizeof(int));
    for (int i = 0; i < factorySize; i++) {
        factories[i] = factory[i][0];
    }
    qsort(factories, factorySize, sizeof(int), cmp);

    long long** dp = malloc((factorySize + 1) * sizeof(long long*));
    for (int i = 0; i <= factorySize; i++) {
        dp[i] = malloc((robotSize + 1) * sizeof(long long));
        for (int j = 0; j <= robotSize; j++) {
            dp[i][j] = 1e18;
        }
    }

    dp[0][0] = 0;

    for (int i = 0; i < factorySize; i++) {
        for (int j = 0; j <= robotSize; j++) {
            if (dp[i][j] == 1e18) continue;

            long long sum = 0;
            dp[i + 1][j] = dp[i + 1][j] < dp[i][j] ? dp[i + 1][j] : dp[i][j];

            for (int k = 1; k <= factory[i][1] && j + k <= robotSize; k++) {
                sum += llabs((long long)factories[i] - (long long)robot[j + k - 1]);
                if (dp[i + 1][j + k] > dp[i][j] + sum) {
                    dp[i + 1][j + k] = dp[i][j] + sum;
                }
            }
        }
    }

    long long result = dp[factorySize][robotSize];

    for (int i = 0; i <= factorySize; i++) {
        free(dp[i]);
    }
    free(dp);
    free(factories);

    return result;
}