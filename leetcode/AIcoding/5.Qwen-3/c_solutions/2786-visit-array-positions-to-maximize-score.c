#include <stdio.h>
#include <stdlib.h>

int maxScore(int* nums, int numsSize) {
    int n = numsSize;
    int* dp = (int*)malloc(n * sizeof(int));
    int* visited = (int*)calloc(n, sizeof(int));
    int maxScore = 0;

    for (int i = 0; i < n; i++) {
        dp[i] = nums[i];
    }

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            int j = i;
            int sum = 0;
            while (!visited[j]) {
                visited[j] = 1;
                sum += nums[j];
                j = (j + nums[j]) % n;
            }
            for (int k = 0; k < n; k++) {
                if (!visited[k]) {
                    dp[k] = fmax(dp[k], sum);
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        maxScore = fmax(maxScore, dp[i]);
    }

    free(dp);
    free(visited);
    return maxScore;
}