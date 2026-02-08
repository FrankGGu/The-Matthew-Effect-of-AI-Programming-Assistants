#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int maximumLength(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int n = numsSize;
    int dp[n];
    for (int i = 0; i < n; i++) {
        dp[i] = 1;
    }
    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] % nums[j] == 0) {
                dp[i] = fmax(dp[i], dp[j] + 1);
            }
        }
    }
    int maxLen = 0;
    for (int i = 0; i < n; i++) {
        maxLen = fmax(maxLen, dp[i]);
    }
    return maxLen;
}