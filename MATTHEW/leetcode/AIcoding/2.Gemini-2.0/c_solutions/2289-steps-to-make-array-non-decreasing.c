#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int totalSteps(int* nums, int numsSize) {
    int stack[numsSize];
    int top = -1;
    int dp[numsSize];
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 0;
    }
    int ans = 0;

    for (int i = numsSize - 1; i >= 0; i--) {
        while (top >= 0 && nums[i] > nums[stack[top]]) {
            dp[i] = fmax(dp[i] + 1, dp[stack[top]] + 1);
            top--;
        }
        stack[++top] = i;
        ans = fmax(ans, dp[i]);
    }

    return ans;
}