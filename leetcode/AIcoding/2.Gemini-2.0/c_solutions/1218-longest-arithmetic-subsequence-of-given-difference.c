#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubsequence(int* arr, int arrSize, int difference) {
    int *dp = (int*)malloc(sizeof(int) * 40001);
    for (int i = 0; i < 40001; i++) {
        dp[i] = 0;
    }

    int ans = 0;
    for (int i = 0; i < arrSize; i++) {
        int index = arr[i] + 20000;
        int prevIndex = arr[i] - difference + 20000;

        if (prevIndex >= 0 && prevIndex <= 40000) {
            dp[index] = dp[prevIndex] + 1;
        } else {
            dp[index] = 1;
        }
        if (dp[index] > ans) {
            ans = dp[index];
        }
    }

    free(dp);
    return ans;
}