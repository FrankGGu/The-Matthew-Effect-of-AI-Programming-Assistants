#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int constrainedSubsetSum(int* nums, int numsSize, int k) {
    int* dp = (int*)malloc(sizeof(int) * numsSize);
    int* deque = (int*)malloc(sizeof(int) * numsSize);
    int head = 0, tail = 0;

    int maxSum = nums[0];
    for (int i = 0; i < numsSize; i++) {
        while (head < tail && deque[head] < i - k) {
            head++;
        }

        dp[i] = nums[i];
        if (head < tail) {
            dp[i] = nums[i] + (dp[deque[head]] > 0 ? dp[deque[head]] : 0);
        }

        maxSum = (maxSum > dp[i] ? maxSum : dp[i]);

        while (head < tail && dp[deque[tail - 1]] <= dp[i]) {
            tail--;
        }
        deque[tail++] = i;
    }

    free(dp);
    free(deque);
    return maxSum;
}