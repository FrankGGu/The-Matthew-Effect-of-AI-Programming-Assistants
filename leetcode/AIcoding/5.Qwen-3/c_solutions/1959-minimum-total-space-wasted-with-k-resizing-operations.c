#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minSpaceWastedKResizing(int* nums, int numsSize, int k) {
    int n = numsSize;
    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((k + 1) * sizeof(int));
        for (int j = 0; j <= k; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    qsort(nums, n, sizeof(int), compare);

    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for (int i = 0; i <= n; i++) {
        dp[i][0] = 0;
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            for (int m = 0; m < i; m++) {
                if (dp[m][j - 1] == INT_MAX) continue;
                int avg = (prefix[i] - prefix[m]) / (i - m);
                int total = 0;
                for (int p = m; p < i; p++) {
                    total += abs(nums[p] - avg);
                }
                dp[i][j] = fmin(dp[i][j], dp[m][j - 1] + total);
            }
        }
    }

    int result = dp[n][k];
    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);
    free(prefix);
    return result;
}